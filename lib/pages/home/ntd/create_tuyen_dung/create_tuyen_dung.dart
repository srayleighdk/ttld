import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/do_tuoi_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

// Step data class for better organization
class StepData {
  final String title;
  final String subtitle;
  final IconData icon;
  bool isCompleted;

  StepData({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isCompleted = false,
  });
}

class CreateTuyenDungPage extends StatefulWidget {
  final Ntd? ntd;
  final NTDTuyenDung? tuyenDung;
  final bool isEdit;
  static const routePath = '/ntd_home/create_tuyen_dung';
  const CreateTuyenDungPage({
    super.key,
    this.ntd,
    this.tuyenDung,
    this.isEdit = false,
  });

  @override
  State<CreateTuyenDungPage> createState() => _CreateTuyenDungPageState();
}

class _CreateTuyenDungPageState extends State<CreateTuyenDungPage>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Page controller for smooth transitions
  late PageController _pageController;
  int _currentStep = 0;

  // Form keys for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text controllers with organized naming
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _otherIndustryController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _heightRequirementController =
      TextEditingController();
  final TextEditingController _applicationLocationController =
      TextEditingController(text: 'TRUNG TÂM DỊCH VỤ VIỆC LÀM BÌNH ĐỊNH');
  final TextEditingController _documentsRequiredController = TextEditingController(
      text:
          'Đơn xin việc, sơ yếu lý lịch, bản photo giấy khám sức khỏe, hộ khẩu, CMND, bằng cấp có liên quan và 1 ảnh (3x4)');
  final TextEditingController _notesController = TextEditingController();

  // Data model
  late NTDTuyenDung _tuyenDungData = widget.tuyenDung ??
      NTDTuyenDung(
        idTuyenDung: null,
        tdTieude: '',
        tdChucDanh: 0,
        tdNganhkhac: '',
        tdSoluong: 0,
        tdMotacongviec: '',
        tdMotayeucau: '',
        tdQuyenloi: '',
        tdGhichu: '',
        tdLuongkhoidiem: 0,
        ngayNhanHoSo: '',
        ngayHetNhanHoSo: '',
        isDenKhiTuyenXong: true,
        tdNoinophoso: '',
        tdHosobaogom: '',
        tdYeuCauChieuCao: 0,
        tdYeucauKinhnghiem: 0,
        tdYeucauTuoiMin: 0,
        tdYeucauTuoiMax: 0,
        tdLanxem: 0,
        tdDuyet: false,
        createdDate: DateTime.now(),
        createdBy: '',
        modifiredDate: DateTime.now(),
        modifiredBy: '',
        tdId: null,
        tdIdDoanhnghiep: widget.ntd?.idDoanhNghiep ?? '',
        nguonThuThap: '',
        soLuongDat: 0,
        soLuongKhongDat: 0,
        soLuongChoKetQua: 0,
        idMucLuong: 0,
        idDoTuoi: 0,
        doanhNghiepYeuCau: '',
        idDoituongCs: 0,
        idphieut11: null,
        idDoanhNghiep: widget.ntd?.idDoanhNghiep ?? '',
        tdNoilamviec: 0,
        tdNganhnghe: 0,
        tdYeuCauHocVan: 0,
        tdThoigianlamviec: 0,
        idKinhnghiem: null,
        idBacHoc: null,
        idKynang: null,
        idHinhthucLv: null,
        tdYeuCauTinHoc: null,
        tdYeuCauNgoaiNgu: null,
        tdYeuCauGioiTinh: 0,
        maHoso: null,
        nguoiLienhe: '',
        soDienthoai: '',
        diaChiDn: '',
        tenDoanhNghiep: '',
        noiLamviec: '',
        tenNganhnghe: '',
        mucLuong: '',
      );

  // Step definitions with icons and descriptions
  final List<StepData> _steps = [
    StepData(
      title: 'Thông tin cơ bản',
      subtitle: 'Tiêu đề, vị trí, ngành nghề',
      icon: Icons.work_outline,
      isCompleted: false,
    ),
    StepData(
      title: 'Yêu cầu ứng viên',
      subtitle: 'Học vấn, kinh nghiệm, kỹ năng',
      icon: Icons.person_search_outlined,
      isCompleted: false,
    ),
    StepData(
      title: 'Thông tin hồ sơ',
      subtitle: 'Thời hạn, tài liệu, liên hệ',
      icon: Icons.description_outlined,
      isCompleted: false,
    ),
  ];

  // Loading state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializePageController();
    // _validateNTDData();
    _initializeFormData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  void _initializePageController() {
    _pageController = PageController();
  }

  // void _validateNTDData() {
  //   final idDoanhNghiep = widget.ntd?.idDoanhNghiep;
  //
  //   if (widget.ntd == null || idDoanhNghiep == null || idDoanhNghiep.isEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (!mounted) return;
  //       _showErrorAndExit('Vui lòng đăng nhập lại để tạo bài tuyển dụng.');
  //     });
  //     return;
  //   }
  // }

  void _initializeFormData() {
    if (widget.tuyenDung != null) {
      _tuyenDungData = widget.tuyenDung!;
      _populateControllersFromData();
    }
  }

  void _showErrorAndExit(String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _titleController.dispose();
    _positionController.dispose();
    _otherIndustryController.dispose();
    _quantityController.dispose();
    _salaryController.dispose();
    _jobDescriptionController.dispose();
    _benefitsController.dispose();
    _requirementsController.dispose();
    _heightRequirementController.dispose();
    _applicationLocationController.dispose();
    _documentsRequiredController.dispose();
    _notesController.dispose();
  }

  void _populateControllersFromData() {
    _titleController.text = _tuyenDungData.tdTieude ?? '';
    _positionController.text = _tuyenDungData.tdChucDanh?.toString() ?? '';
    _otherIndustryController.text = _tuyenDungData.tdNganhkhac ?? '';
    _quantityController.text = _tuyenDungData.tdSoluong?.toString() ?? '';
    _salaryController.text = _tuyenDungData.tdLuongkhoidiem?.toString() ?? '';
    _jobDescriptionController.text = _tuyenDungData.tdMotacongviec ?? '';
    _benefitsController.text = _tuyenDungData.tdQuyenloi ?? '';
    _requirementsController.text = _tuyenDungData.tdMotayeucau ?? '';
    _heightRequirementController.text =
        _tuyenDungData.tdYeuCauChieuCao?.toString() ?? '';
    _applicationLocationController.text = _tuyenDungData.tdNoinophoso ?? '';
    _documentsRequiredController.text = _tuyenDungData.tdHosobaogom ?? '';
    _notesController.text = _tuyenDungData.tdGhichu ?? '';
  }

  void _updateTuyenDungData() {
    _tuyenDungData = _tuyenDungData.copyWith(
      tdTieude: _titleController.text,
      tdChucDanh: int.tryParse(_positionController.text) ?? 0,
      tdNganhkhac: _otherIndustryController.text,
      tdSoluong: int.tryParse(_quantityController.text) ?? 0,
      tdLuongkhoidiem: int.tryParse(_salaryController.text) ?? 0,
      tdMotacongviec: _jobDescriptionController.text,
      tdQuyenloi: _benefitsController.text,
      tdMotayeucau: _requirementsController.text,
      tdYeuCauChieuCao: int.tryParse(_heightRequirementController.text) ?? 0,
      tdNoinophoso: _applicationLocationController.text,
      tdHosobaogom: _documentsRequiredController.text,
      tdGhichu: _notesController.text,
      idDoanhNghiep: widget.ntd?.idDoanhNghiep ?? '',
      tdIdDoanhnghiep: widget.ntd?.idDoanhNghiep ?? '',
      createdDate: DateTime.now(),
      modifiredDate: DateTime.now(),
      tdDuyet: false,
      tdLanxem: 0,
      ngayNhanHoSo: DateTime.now().toIso8601String(),
      ngayHetNhanHoSo:
          DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      isDenKhiTuyenXong: true,
    );
  }

  // Navigation methods
  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      if (_validateCurrentStep()) {
        setState(() {
          _steps[_currentStep].isCompleted = true;
          _currentStep++;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        HapticFeedback.lightImpact();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  void _goToStep(int step) {
    if (step >= 0 && step < _steps.length) {
      setState(() {
        _currentStep = step;
      });
      _pageController.animateToPage(
        step,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _validateStep1();
      case 1:
        return _validateStep2();
      case 2:
        return _validateStep3();
      default:
        return true;
    }
  }

  bool _validateStep1() {
    List<String> missingFields = [];

    if (_titleController.text.trim().isEmpty) {
      missingFields.add('Tiêu đề tuyển dụng');
    }
    if (_positionController.text.trim().isEmpty) {
      missingFields.add('Vị trí tuyển dụng');
    }
    if (_quantityController.text.trim().isEmpty) {
      missingFields.add('Số lượng tuyển');
    }
    if (_salaryController.text.trim().isEmpty) {
      missingFields.add('Lương khởi điểm');
    }
    if (_jobDescriptionController.text.trim().isEmpty) {
      missingFields.add('Mô tả công việc');
    }
    if (_benefitsController.text.trim().isEmpty) {
      missingFields.add('Quyền lợi');
    }
    if (_tuyenDungData.tdNganhnghe == null || _tuyenDungData.tdNganhnghe == 0) {
      missingFields.add('Ngành nghề');
    }
    if (_tuyenDungData.tdNoilamviec == null ||
        _tuyenDungData.tdNoilamviec == 0) {
      missingFields.add('Nơi làm việc');
    }
    if (_tuyenDungData.tdThoigianlamviec == null ||
        _tuyenDungData.tdThoigianlamviec == 0) {
      missingFields.add('Thời gian làm việc');
    }

    if (missingFields.isNotEmpty) {
      _showValidationError('Bước 1: ${missingFields.join(', ')}');
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    List<String> missingFields = [];

    if (_tuyenDungData.tdYeuCauHocVan == null ||
        _tuyenDungData.tdYeuCauHocVan == 0) {
      missingFields.add('Trình độ học vấn');
    }
    if (_tuyenDungData.idBacHoc == null || _tuyenDungData.idBacHoc == '') {
      missingFields.add('Trình độ chuyên môn');
    }
    if (_tuyenDungData.tdYeuCauTinHoc == null ||
        _tuyenDungData.tdYeuCauTinHoc == '') {
      missingFields.add('Trình độ tin học');
    }
    if (_tuyenDungData.idKinhnghiem == null ||
        _tuyenDungData.idKinhnghiem == '') {
      missingFields.add('Kinh nghiệm làm việc');
    }

    if (missingFields.isNotEmpty) {
      _showValidationError('Bước 2: ${missingFields.join(', ')}');
      return false;
    }
    return true;
  }

  bool _validateStep3() {
    List<String> missingFields = [];

    if (_applicationLocationController.text.trim().isEmpty) {
      missingFields.add('Nơi nộp hồ sơ');
    }
    if (_documentsRequiredController.text.trim().isEmpty) {
      missingFields.add('Hồ sơ bao gồm');
    }

    if (missingFields.isNotEmpty) {
      _showValidationError('Bước 3: ${missingFields.join(', ')}');
      return false;
    }
    return true;
  }

  bool _validateAllSteps() {
    return _validateStep1() && _validateStep2() && _validateStep3();
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Vui lòng điền đầy đủ thông tin: $message'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_validateAllSteps()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _updateTuyenDungData();

      final bloc = locator<TuyenDungBloc>();
      if (widget.isEdit) {
        bloc.add(TuyenDungEvent.update(_tuyenDungData));
      } else {
        bloc.add(TuyenDungEvent.create(_tuyenDungData));
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEdit
              ? 'Cập nhật bài tuyển dụng thành công!'
              : 'Tạo bài tuyển dụng thành công!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Wait for the creation to complete and refresh the list
      await Future.delayed(const Duration(milliseconds: 500));
      bloc.add(TuyenDungEvent.fetchList(widget.ntd?.idDoanhNghiep));

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Có lỗi xảy ra: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              _buildStepIndicator(theme),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentStep = index;
                    });
                  },
                  children: [
                    _buildStep1(theme),
                    _buildStep2(theme),
                    _buildStep3(theme),
                  ],
                ),
              ),
              _buildNavigationButtons(theme),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return CustomAppBar(
      title: widget.isEdit ? 'Chỉnh sửa tuyển dụng' : 'Tạo bài tuyển dụng',
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Bước ${_currentStep + 1} / ${_steps.length}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: List.generate(_steps.length, (index) {
          final step = _steps[index];
          final isActive = index == _currentStep;
          final isCompleted = step.isCompleted;

          return Expanded(
            child: GestureDetector(
              onTap: () => _goToStep(index),
              child: Container(
                margin:
                    EdgeInsets.only(right: index < _steps.length - 1 ? 8 : 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Step circle
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? Colors.green
                                : isActive
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline
                                        .withOpacity(0.3),
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : step.icon,
                            color: isCompleted || isActive
                                ? Colors.white
                                : theme.colorScheme.outline,
                            size: 20,
                          ),
                        ),
                        // Progress line
                        if (index < _steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              color: isCompleted
                                  ? Colors.green
                                  : theme.colorScheme.outline.withOpacity(0.3),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step.title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      step.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: theme.colorScheme.onSurface.withOpacity(0.4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNavigationButtons(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _previousStep,
                icon: const Icon(Icons.arrow_back),
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
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: _isLoading
                  ? null
                  : _currentStep < _steps.length - 1
                      ? _nextStep
                      : _submitForm,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(_currentStep < _steps.length - 1
                      ? Icons.arrow_forward
                      : Icons.check),
              label: Text(_currentStep < _steps.length - 1
                  ? 'Tiếp theo'
                  : widget.isEdit
                      ? 'Cập nhật'
                      : 'Tạo mới'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildModernCard(
              theme,
              'Thông tin cơ bản',
              Icons.work_outline,
              [
                CustomTextField(
                  labelText: 'Tiêu đề tuyển dụng',
                  controller: _titleController,
                  hintText: 'Nhập tiêu đề tuyển dụng',
                  validator: 'not_empty',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Vị trí tuyển dụng',
                  controller: _positionController,
                  hintText: 'Nhập vị trí tuyển dụng',
                  validator: 'not_empty',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
                const SizedBox(height: 16),
                CustomPickerGrok<NganhNgheTD>(
                  label: const Text('Ngành nghề tuyển dụng *'),
                  selectedItem: () {
                    try {
                      final nganhNgheList = locator<List<NganhNgheTD>>();
                      return nganhNgheList.firstWhere(
                        (e) => e.id == _tuyenDungData.tdNganhnghe,
                        orElse: () =>
                            NganhNgheTD(id: 0, name: 'Chọn ngành nghề'),
                      );
                    } catch (e) {
                      return NganhNgheTD(id: 0, name: 'Chọn ngành nghề');
                    }
                  }(),
                  items: () {
                    try {
                      return locator<List<NganhNgheTD>>();
                    } catch (e) {
                      return <NganhNgheTD>[];
                    }
                  }(),
                  onChanged: (NganhNgheTD? value) {
                    _tuyenDungData = _tuyenDungData.copyWith(
                      tdNganhnghe: value?.id,
                    );
                    _updateTuyenDungData();
                  },
                  displayItemBuilder: (NganhNgheTD? value) =>
                      '${value?.displayName}',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Ngành khác (tùy chọn)',
                  controller: _otherIndustryController,
                  hintText: 'Nhập ngành khác nếu có',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildModernCard(
              theme,
              'Địa điểm và thời gian',
              Icons.location_on_outlined,
              [
                CustomPickerGrok<TinhThanhModel>(
                  label: const Text('Nơi làm việc *'),
                  selectedItem: () {
                    try {
                      return locator<List<TinhThanhModel>>().firstWhere(
                        (e) => e.id == _tuyenDungData.tdNoilamviec,
                        orElse: () =>
                            TinhThanhModel(tpId: 0, tpTen: 'Chọn nơi làm việc'),
                      );
                    } catch (e) {
                      return TinhThanhModel(
                          tpId: 0, tpTen: 'Chọn nơi làm việc');
                    }
                  }(),
                  items: () {
                    try {
                      return locator<List<TinhThanhModel>>();
                    } catch (e) {
                      return <TinhThanhModel>[];
                    }
                  }(),
                  onChanged: (TinhThanhModel? value) {
                    _tuyenDungData = _tuyenDungData.copyWith(
                      tdNoilamviec: value?.id,
                    );
                    _updateTuyenDungData();
                  },
                  displayItemBuilder: (TinhThanhModel? value) =>
                      '${value?.displayName}',
                ),
                const SizedBox(height: 16),
                CustomPickerGrok<ThoiGianLamViec>(
                  label: const Text('Thời gian làm việc *'),
                  selectedItem: () {
                    try {
                      return locator<List<ThoiGianLamViec>>().firstWhere(
                        (e) => e.id == _tuyenDungData.tdThoigianlamviec,
                        orElse: () => ThoiGianLamViec(
                          id: 0,
                          name: 'Chọn thời gian',
                          idhinhthuclamviec: '0',
                          displayOrder: 0,
                          status: true,
                        ),
                      );
                    } catch (e) {
                      return ThoiGianLamViec(
                        id: 0,
                        name: 'Chọn thời gian',
                        idhinhthuclamviec: '0',
                        displayOrder: 0,
                        status: true,
                      );
                    }
                  }(),
                  items: () {
                    try {
                      return locator<List<ThoiGianLamViec>>();
                    } catch (e) {
                      return <ThoiGianLamViec>[];
                    }
                  }(),
                  onChanged: (ThoiGianLamViec? value) {
                    if (value == null) return;
                    _tuyenDungData = _tuyenDungData.copyWith(
                      tdThoigianlamviec: value.id,
                    );
                    _updateTuyenDungData();
                  },
                  displayItemBuilder: (ThoiGianLamViec? value) =>
                      '${value?.displayName}',
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildModernCard(
              theme,
              'Lương và số lượng',
              Icons.monetization_on_outlined,
              [
                CustomTextField.numberGrok(
                  labelText: 'Lương khởi điểm (VNĐ)',
                  controller: _salaryController,
                  hintText: 'Nhập mức lương khởi điểm',
                  validator: 'not_empty',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
                const SizedBox(height: 16),
                CustomTextField.numberGrok(
                  labelText: 'Số lượng tuyển',
                  controller: _quantityController,
                  hintText: 'Nhập số lượng cần tuyển',
                  validator: 'not_empty',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildModernCard(
              theme,
              'Mô tả công việc',
              Icons.description_outlined,
              [
                CustomTextField.textArea(
                  labelText: 'Mô tả công việc',
                  controller: _jobDescriptionController,
                  hintText: 'Mô tả chi tiết về công việc, trách nhiệm...',
                  validator: 'not_empty',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
                const SizedBox(height: 16),
                CustomTextField.textArea(
                  labelText: 'Quyền lợi',
                  hintText: 'Mô tả quyền lợi: bảo hiểm, chế độ, phúc lợi...',
                  controller: _benefitsController,
                  validator: 'not_empty',
                  onChanged: (value) => _updateTuyenDungData(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildModernCard(
            theme,
            'Yêu cầu học vấn',
            Icons.school_outlined,
            [
              CustomPickerGrok<TrinhDoHocVan>(
                label: const Text('Trình độ văn hóa *'),
                selectedItem: () {
                  try {
                    return locator<List<TrinhDoHocVan>>().firstWhere(
                      (e) => e.id == _tuyenDungData.tdYeuCauHocVan,
                      orElse: () => TrinhDoHocVan(id: 0, name: 'Chọn trình độ'),
                    );
                  } catch (e) {
                    return TrinhDoHocVan(id: 0, name: 'Chọn trình độ');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<TrinhDoHocVan>>();
                  } catch (e) {
                    return <TrinhDoHocVan>[];
                  }
                }(),
                onChanged: (TrinhDoHocVan? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdYeuCauHocVan: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TrinhDoHocVan? value) =>
                    '${value?.displayName}',
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<TrinhDoChuyenMon>(
                label: const Text('Trình độ chuyên môn *'),
                selectedItem: () {
                  try {
                    return locator<List<TrinhDoChuyenMon>>().firstWhere(
                      (e) => e.id == _tuyenDungData.idBacHoc,
                      orElse: () =>
                          TrinhDoChuyenMon(id: '', name: 'Chọn trình độ'),
                    );
                  } catch (e) {
                    return TrinhDoChuyenMon(id: '', name: 'Chọn trình độ');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<TrinhDoChuyenMon>>();
                  } catch (e) {
                    return <TrinhDoChuyenMon>[];
                  }
                }(),
                onChanged: (TrinhDoChuyenMon? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idBacHoc: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TrinhDoChuyenMon? value) =>
                    '${value?.displayName}',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernCard(
            theme,
            'Yêu cầu kỹ năng',
            Icons.computer_outlined,
            [
              CustomPickerGrok<TrinhDoTinHoc>(
                label: const Text('Trình độ tin học *'),
                selectedItem: () {
                  try {
                    return locator<List<TrinhDoTinHoc>>().firstWhere(
                      (e) => e.id == _tuyenDungData.tdYeuCauTinHoc,
                      orElse: () =>
                          TrinhDoTinHoc(id: '', name: 'Chọn trình độ'),
                    );
                  } catch (e) {
                    return TrinhDoTinHoc(id: '', name: 'Chọn trình độ');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<TrinhDoTinHoc>>();
                  } catch (e) {
                    return <TrinhDoTinHoc>[];
                  }
                }(),
                onChanged: (TrinhDoTinHoc? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdYeuCauTinHoc: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (TrinhDoTinHoc? value) =>
                    '${value?.displayName}',
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<KinhNghiemLamViec>(
                label: const Text('Kinh nghiệm làm việc *'),
                selectedItem: () {
                  try {
                    return locator<List<KinhNghiemLamViec>>().firstWhere(
                      (e) => e.id.toString() == _tuyenDungData.idKinhnghiem,
                      orElse: () => KinhNghiemLamViec(
                          id: '0', displayName: 'Chọn kinh nghiệm'),
                    );
                  } catch (e) {
                    return KinhNghiemLamViec(
                        id: '0', displayName: 'Chọn kinh nghiệm');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<KinhNghiemLamViec>>();
                  } catch (e) {
                    return <KinhNghiemLamViec>[];
                  }
                }(),
                onChanged: (KinhNghiemLamViec? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idKinhnghiem: value?.id.toString(),
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (KinhNghiemLamViec? value) =>
                    '${value?.displayName}',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernCard(
            theme,
            'Yêu cầu cá nhân',
            Icons.person_outline,
            [
              CustomPickerMap(
                label: const Text('Giới tính'),
                items: gioiTinhOptions,
                selectedItem: _tuyenDungData.tdYeuCauGioiTinh ?? -1,
                onChanged: (gioiTinh) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    tdYeuCauGioiTinh: gioiTinh!,
                  );
                  _updateTuyenDungData();
                },
              ),
              const SizedBox(height: 16),
              CustomTextField.numberGrok(
                labelText: 'Chiều cao (cm)',
                controller: _heightRequirementController,
                hintText: 'Nhập chiều cao yêu cầu (tùy chọn)',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<DoTuoi>(
                label: const Text('Độ tuổi'),
                selectedItem: () {
                  try {
                    return locator<List<DoTuoi>>().firstWhere(
                      (e) => e.id == _tuyenDungData.idDoTuoi,
                      orElse: () =>
                          DoTuoi(idDoTuoi: 0, tenDoTuoi: 'Chọn độ tuổi'),
                    );
                  } catch (e) {
                    return DoTuoi(idDoTuoi: 0, tenDoTuoi: 'Chọn độ tuổi');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<DoTuoi>>();
                  } catch (e) {
                    return <DoTuoi>[];
                  }
                }(),
                onChanged: (DoTuoi? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idDoTuoi: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (DoTuoi? value) => '${value?.displayName}',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernCard(
            theme,
            'Thông tin bổ sung',
            Icons.info_outline,
            [
              CustomPickerGrok<DoiTuong>(
                label: const Text('Đối tượng chính sách'),
                selectedItem: () {
                  try {
                    return locator<List<DoiTuong>>().firstWhere(
                      (e) => e.id == _tuyenDungData.idDoituongCs,
                      orElse: () => DoiTuong(id: 0, name: 'Chọn đối tượng'),
                    );
                  } catch (e) {
                    return DoiTuong(id: 0, name: 'Chọn đối tượng');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<DoiTuong>>();
                  } catch (e) {
                    return <DoiTuong>[];
                  }
                }(),
                onChanged: (DoiTuong? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idDoituongCs: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (DoiTuong? value) =>
                    '${value?.displayName}',
              ),
              const SizedBox(height: 16),
              CustomPickerGrok<MucLuongMM>(
                label: const Text('Mức lương'),
                selectedItem: () {
                  try {
                    return locator<List<MucLuongMM>>().firstWhere(
                      (e) => e.id == _tuyenDungData.idMucLuong,
                      orElse: () => MucLuongMM(
                          idMucLuong: 0, tenMucLuong: 'Chọn mức lương'),
                    );
                  } catch (e) {
                    return MucLuongMM(
                        idMucLuong: 0, tenMucLuong: 'Chọn mức lương');
                  }
                }(),
                items: () {
                  try {
                    return locator<List<MucLuongMM>>();
                  } catch (e) {
                    return <MucLuongMM>[];
                  }
                }(),
                onChanged: (MucLuongMM? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    idMucLuong: value?.id,
                  );
                  _updateTuyenDungData();
                },
                displayItemBuilder: (MucLuongMM? value) =>
                    '${value?.displayName}',
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                labelText: 'Yêu cầu khác',
                controller: _requirementsController,
                hintText: 'Mô tả các yêu cầu khác (tùy chọn)',
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep3(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildModernCard(
            theme,
            'Thời gian nhận hồ sơ',
            Icons.schedule_outlined,
            [
              CustomPickDateTimeGrok(
                labelText: 'Ngày bắt đầu nhận hồ sơ',
                onChanged: (value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    ngayNhanHoSo: value!,
                  );
                  _updateTuyenDungData();
                },
              ),
              const SizedBox(height: 16),
              CustomPickDateTimeGrok(
                labelText: 'Ngày kết thúc nhận hồ sơ',
                onChanged: (value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    ngayHetNhanHoSo: value!,
                  );
                  _updateTuyenDungData();
                },
              ),
              const SizedBox(height: 16),
              CustomCheckbox(
                label: 'Đến khi tuyển xong',
                onChanged: (bool? value) {
                  _tuyenDungData = _tuyenDungData.copyWith(
                    isDenKhiTuyenXong: value!,
                  );
                  _updateTuyenDungData();
                },
                value: _tuyenDungData.isDenKhiTuyenXong ?? true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernCard(
            theme,
            'Thông tin nộp hồ sơ',
            Icons.folder_outlined,
            [
              CustomTextField(
                labelText: 'Nơi nộp hồ sơ',
                hintText: 'Địa chỉ nộp hồ sơ',
                controller: _applicationLocationController,
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                labelText: 'Hồ sơ bao gồm',
                hintText: 'Danh sách hồ sơ cần nộp',
                controller: _documentsRequiredController,
                validator: 'not_empty',
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernCard(
            theme,
            'Ghi chú bổ sung',
            Icons.note_outlined,
            [
              CustomTextField.textArea(
                labelText: 'Ghi chú',
                hintText: 'Ghi chú bổ sung (tùy chọn)',
                controller: _notesController,
                onChanged: (value) => _updateTuyenDungData(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernCard(
    ThemeData theme,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
