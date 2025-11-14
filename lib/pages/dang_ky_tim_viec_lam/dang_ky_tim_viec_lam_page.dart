import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/m02tt11_api_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step1_personal_info.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step2_education_experience.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step3_job_conditions.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/step4_training_workplace.dart';

class DangKyTimViecLamPage extends StatefulWidget {
  static const String routePath = '/ntv_home/dang-ky-tim-viec-lam';
  final M02TT11? existingData;

  const DangKyTimViecLamPage({super.key, this.existingData});

  @override
  _DangKyTimViecLamPageState createState() => _DangKyTimViecLamPageState();
}

class _DangKyTimViecLamPageState extends State<DangKyTimViecLamPage> {
  final Map<int, GlobalKey<FormState>> _formKeys = {
    0: GlobalKey<FormState>(),
    1: GlobalKey<FormState>(),
    2: GlobalKey<FormState>(),
    3: GlobalKey<FormState>(),
  };

  int _currentStep = 0;
  final List<String> _stepTitles = [
    'Thông tin\ncá nhân',
    'Trình độ\nkinh nghiệm',
    'Điều kiện\nviệc làm',
    'Đào tạo -\nNơi làm việc',
  ];

  late M02TT11 _formData;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _formData = widget.existingData ?? M02TT11();
  }

  void _updateFormData(M02TT11 updatedData) {
    setState(() {
      _formData = updatedData;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKeys[_currentStep]!.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Call API to create M02TT11 registration
      final apiService = locator<M02TT11ApiService>();
      final result = await apiService.createM02TT11(_formData);

      if (mounted) {
        ToastUtils.showSuccessToast(
          context,
          'Đăng ký tìm việc thành công! Mã phiếu: ${result.maphieu ?? ""}',
        );
        context.pop(result); // Return the created record
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

  void _nextStep() {
    if (_formKeys[_currentStep]!.currentState!.validate()) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 1.0,
        title: Text(
          'Đăng ký tìm việc làm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
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
                  color: Colors.black.withOpacity(0.05),
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

                return Expanded(
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
                                            : theme.colorScheme.onSurfaceVariant,
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
                );
              }),
            ),
          ),

          // Step content
          Expanded(
            child: SingleChildScrollView(
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
                  color: Colors.black.withOpacity(0.05),
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
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Step1PersonalInfo(
          formKey: _formKeys[0]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 1:
        return Step2EducationExperience(
          formKey: _formKeys[1]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 2:
        return Step3JobConditions(
          formKey: _formKeys[2]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      case 3:
        return Step4TrainingWorkplace(
          formKey: _formKeys[3]!,
          formData: _formData,
          onDataChanged: _updateFormData,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
