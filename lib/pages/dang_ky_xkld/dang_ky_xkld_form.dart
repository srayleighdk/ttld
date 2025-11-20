import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/pages/dang_ky_xkld/step1_personal_info.dart';
import 'package:ttld/pages/dang_ky_xkld/step2_address_contact.dart';
import 'package:ttld/pages/dang_ky_xkld/step3_physical_health.dart';
import 'package:ttld/pages/dang_ky_xkld/step4_education_training.dart';
import 'package:ttld/pages/dang_ky_xkld/step5_job_preferences.dart';
import 'package:ttld/services/xkld_draft_service.dart';
import 'package:ttld/services/api/xkld_api_service.dart';
import 'package:ttld/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DangKyXKLDForm extends StatefulWidget {
  static const String routePath = '/ntv_home/dang-ky-xuat-khao-lao-dong';
  final HosoXKLDModel? existingData;

  const DangKyXKLDForm({super.key, this.existingData});

  @override
  _DangKyXKLDFormState createState() => _DangKyXKLDFormState();
}

class _DangKyXKLDFormState extends State<DangKyXKLDForm> {
  final Map<int, GlobalKey<FormState>> _formKeys = {
    0: GlobalKey<FormState>(),
    1: GlobalKey<FormState>(),
    2: GlobalKey<FormState>(),
    3: GlobalKey<FormState>(),
    4: GlobalKey<FormState>(),
  };

  int _currentStep = 0;
  final List<String> _stepTitles = [
    'Thông tin\ncá nhân',
    'Địa chỉ &\nLiên hệ',
    'Sức khỏe &\nThể chất',
    'Học vấn &\nĐào tạo',
    'Nguyện vọng\nlàm việc',
  ];

  late HosoXKLDModel _formData;
  bool _isSubmitting = false;
  bool _isLoadingPrefill = false;
  DateTime? _lastSavedTime;
  Function? _onSuccessCallback;

  final XKLDDraftService _draftService = XKLDDraftService();
  late XKLDApiService _apiService;

  @override
  void initState() {
    super.initState();
    _formData = widget.existingData ??
        HosoXKLDModel(
          dkxkldNgay: DateTime.now().toIso8601String(),
          dkxkldUsername: '', // Should be filled with current user
          dkxkldDuyet: false,
        );
    
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      print('🚀 Initializing XKLD form...');
      
      // Initialize API service first
      final prefs = await SharedPreferences.getInstance();
      _apiService = XKLDApiService(ApiClient(prefs));
      print('✅ API service initialized');
      
      // Then check for draft and prefill
      await _checkForDraftAndPrefill();
      
      // Start auto-save
      _startAutoSave();
      print('✅ Auto-save started');
    } catch (e) {
      print('❌ Error initializing: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get callback from extra
    final state = GoRouterState.of(context);
    _onSuccessCallback = state.extra as Function?;
  }

  /// Check for existing draft and offer to load it
  Future<void> _checkForDraftAndPrefill() async {
    print('🔍 Checking for draft and prefill...');
    
    final hasDraft = await _draftService.hasDraft();
    print('📝 Has draft: $hasDraft');
    
    if (hasDraft && mounted) {
      // Check if draft has actual data
      final draft = await _draftService.loadDraft();
      final hasData = draft?.dkxkldHoten != null && 
                      draft!.dkxkldHoten!.isNotEmpty;
      
      if (hasData) {
        final shouldLoadDraft = await _showDraftDialog();
        print('👤 User chose to load draft: $shouldLoadDraft');
        if (shouldLoadDraft == true) {
          setState(() {
            _formData = draft;
          });
          if (mounted) {
            ToastUtils.showSuccessToast(context, 'Đã tải bản nháp');
          }
          return;
        }
      } else {
        print('⚠️ Draft exists but is empty, clearing it');
        await _draftService.clearDraft();
      }
    }

    // If no draft or user declined, offer to prefill from profile
    if (widget.existingData == null && mounted) {
      print('💡 Showing prefill dialog...');
      final shouldPrefill = await _showPrefillDialog();
      print('👤 User chose to prefill: $shouldPrefill');
      if (shouldPrefill == true) {
        await _loadPrefillData();
      }
    }
  }

  /// Show dialog asking if user wants to load draft
  Future<bool?> _showDraftDialog() async {
    final lastSaved = await _draftService.getLastSavedTime();
    final timeAgo = lastSaved != null
        ? _getTimeAgo(lastSaved)
        : 'không xác định';

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(FontAwesomeIcons.fileLines, color: Colors.blue),
            SizedBox(width: 12),
            Text('Tiếp tục bản nháp?'),
          ],
        ),
        content: Text(
          'Bạn có một bản nháp đã lưu từ $timeAgo. Bạn có muốn tiếp tục?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Bắt đầu mới'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Tiếp tục'),
          ),
        ],
      ),
    );
  }

  /// Show dialog asking if user wants to prefill from profile
  Future<bool?> _showPrefillDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(FontAwesomeIcons.userCheck, color: Colors.green),
            SizedBox(width: 12),
            Text('Điền tự động?'),
          ],
        ),
        content: const Text(
          'Bạn có muốn tự động điền thông tin từ hồ sơ ứng viên của bạn không?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Không'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Có'),
          ),
        ],
      ),
    );
  }



  /// Load prefill data from candidate profile
  Future<void> _loadPrefillData() async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingPrefill = true;
    });

    try {
      print('🔄 Fetching prefill data...');
      final prefillData = await _apiService.getPrefillData();
      
      if (prefillData != null) {
        print('✅ Prefill data received: ${prefillData.dkxkldHoten}');
        if (mounted) {
          setState(() {
            // Clear address fields that might cause dropdown issues
            // User can re-select them from dropdowns
            _formData = prefillData.copyWith(
              dkxkldNgay: DateTime.now().toIso8601String(),
              dkxkldDuyet: false,
              tinh: null, // Clear to avoid dropdown mismatch
              huyenThiThanhPho: null,
              xaPhuong: null,
            );
          });
          ToastUtils.showSuccessToast(
            context,
            'Đã điền tự động thông tin từ hồ sơ. Vui lòng chọn lại địa chỉ.',
          );
        }
      } else {
        print('⚠️ No prefill data returned');
        if (mounted) {
          ToastUtils.showErrorToast(
            context,
            'Không tìm thấy hồ sơ ứng viên',
          );
        }
      }
    } catch (e) {
      print('❌ Error loading prefill data: $e');
      if (mounted) {
        ToastUtils.showErrorToast(
          context,
          'Không thể tải thông tin: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingPrefill = false;
        });
      }
    }
  }

  /// Start auto-save timer
  void _startAutoSave() {
    _draftService.startAutoSave(
      _formData,
      () => _formData,
      (savedTime) {
        if (mounted) {
          setState(() {
            _lastSavedTime = savedTime;
          });
        }
      },
    );
  }

  /// Manually save draft
  Future<void> _saveDraft() async {
    await _draftService.saveDraft(_formData);
    if (mounted) {
      setState(() {
        _lastSavedTime = DateTime.now();
      });
      ToastUtils.showSuccessToast(context, 'Đã lưu bản nháp');
    }
  }

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'vừa xong';
    if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
    if (diff.inHours < 24) return '${diff.inHours} giờ trước';
    return '${diff.inDays} ngày trước';
  }

  void _updateFormData(HosoXKLDModel updatedData) {
    setState(() {
      _formData = updatedData;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKeys[_currentStep]!.currentState!.validate()) {
      return;
    }

    // Show confirmation dialog
    final confirmed = await _showSubmitConfirmation();
    if (confirmed != true) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await _apiService.submitApplication(_formData);

      if (mounted && response['success'] == true) {
        // Clear draft after successful submission
        await _draftService.clearDraft();
        
        ToastUtils.showSuccessToast(
          context,
          'Đăng ký xuất khẩu lao động thành công!',
        );
        _onSuccessCallback?.call();
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showErrorToast(
          context,
          'Đăng ký thất bại: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<bool?> _showSubmitConfirmation() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận gửi đơn'),
        content: const Text(
          'Bạn có chắc chắn muốn gửi đơn đăng ký xuất khẩu lao động? '
          'Vui lòng kiểm tra kỹ thông tin trước khi gửi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Kiểm tra lại'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xác nhận gửi'),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_formKeys[_currentStep]!.currentState!.validate()) {
      // Save progress before moving to next step
      _draftService.saveDraft(_formData);
      
      if (_currentStep < _stepTitles.length - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        _submitForm();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _jumpToStep(int step) {
    if (step < _currentStep || _formKeys[_currentStep]!.currentState!.validate()) {
      setState(() {
        _currentStep = step;
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (_isSubmitting) return false;

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thoát khỏi biểu mẫu?'),
        content: const Text(
          'Thông tin của bạn đã được lưu tự động. Bạn có thể quay lại sau.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Ở lại'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Thoát'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: theme.colorScheme.surface,
          scrolledUnderElevation: 1.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đăng ký xuất khẩu lao động',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
              if (_lastSavedTime != null)
                Text(
                  'Đã lưu ${_getTimeAgo(_lastSavedTime!)}',
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) {
                context.pop();
              }
            },
          ),
          actions: [
            if (!_isSubmitting)
              IconButton(
                icon: const Icon(FontAwesomeIcons.floppyDisk, size: 20),
                tooltip: 'Lưu bản nháp',
                onPressed: _saveDraft,
              ),
          ],
        ),
        body: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_stepTitles.length, (index) {
                  final isCompleted = index < _currentStep;
                  final isCurrent = index == _currentStep;
                  final canNavigate = index <= _currentStep;

                  return Expanded(
                    child: GestureDetector(
                      onTap: canNavigate ? () => _jumpToStep(index) : null,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (index > 0)
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    color: isCompleted
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.surfaceContainerHighest,
                                  ),
                                ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isCompleted || isCurrent
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.surfaceContainerHighest,
                                  border: Border.all(
                                    color: isCompleted || isCurrent
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.outline,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: isCompleted
                                      ? Icon(
                                          FontAwesomeIcons.check,
                                          size: 16,
                                          color: theme.colorScheme.onPrimary,
                                        )
                                      : Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: isCurrent
                                                ? theme.colorScheme.onPrimary
                                                : theme
                                                    .colorScheme.onSurfaceVariant,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                              if (index < _stepTitles.length - 1)
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    color: isCompleted
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.surfaceContainerHighest,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _stepTitles[index],
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isCurrent
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                              fontWeight:
                                  isCurrent ? FontWeight.bold : FontWeight.normal,
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Step content
            Expanded(
              child: _isLoadingPrefill
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            'Đang tải thông tin...',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: _buildStepContent(),
                    ),
            ),

            // Navigation buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isSubmitting ? null : _previousStep,
                        icon: const Icon(FontAwesomeIcons.arrowLeft, size: 16),
                        label: const Text('Quay lại'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _nextStep,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              _currentStep == _stepTitles.length - 1
                                  ? FontAwesomeIcons.check
                                  : FontAwesomeIcons.arrowRight,
                              size: 16,
                            ),
                      label: Text(
                        _currentStep == _stepTitles.length - 1
                            ? 'Hoàn thành'
                            : 'Tiếp theo',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return XKLDStep1PersonalInfo(
          formKey: _formKeys[0]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 1:
        return XKLDStep2AddressContact(
          formKey: _formKeys[1]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 2:
        return XKLDStep3PhysicalHealth(
          formKey: _formKeys[2]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 3:
        return XKLDStep4EducationTraining(
          formKey: _formKeys[3]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 4:
        return XKLDStep5JobPreferences(
          formKey: _formKeys[4]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _draftService.dispose();
    super.dispose();
  }
}
