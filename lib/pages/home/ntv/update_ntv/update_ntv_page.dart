import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/models/trinh_do_van_hoa_model.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/pages/home/ntv/update_ntv/step1_personal_info.dart';
import 'package:ttld/pages/home/ntv/update_ntv/step2_display_settings.dart';
import 'package:ttld/pages/home/ntv/update_ntv/step3_job_preferences.dart';

class UpdateNTVPage extends StatefulWidget {
  final TblHoSoUngVienModel? hoSoUngVien;
  static const routePath = '/update_ntv';
  const UpdateNTVPage({super.key, this.hoSoUngVien});

  @override
  _UpdateNTVPageState createState() => _UpdateNTVPageState();
}

class _UpdateNTVPageState extends State<UpdateNTVPage> {
  final Map<int, GlobalKey<FormState>> _formKeys = {
    0: GlobalKey<FormState>(),
    1: GlobalKey<FormState>(),
    2: GlobalKey<FormState>(),
  };
  int _currentStep = 0;
  final List<String> _steps = [
    'Thông tin\ncá nhân',
    'Hiện thị\nthông tin',
    'Việc làm\nmong muốn',
  ];
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _hotenController = TextEditingController();
  final _emailController = TextEditingController();
  final _maHoSoController = TextEditingController();
  int? _idDanToc;
  final _cvMongMuonController = TextEditingController();
  final _documentPathController = TextEditingController();
  final _imagePathController = TextEditingController();
  final _diachichitietController = TextEditingController();
  final _dienthoaiController = TextEditingController();
  final _cmndController = TextEditingController();
  String? _uvNgaycap;
  final _uvnoicapController = TextEditingController();
  int? _uvGioitinh;
  final _uvchieucaoController = TextEditingController();
  final _uvcannangController = TextEditingController();
  String? _uvDoiTuongChingSach;
  int? _uvDoiTuongChingSachId;
  String? _uvTinhtrangtantat;
  int? _uvTinhtrangtantatId;
  bool? _uvHonnhanId;
  String? _uvngaysinhController;
  final _uvcmCongviechientaiController = TextEditingController();
  String? _uvnvNganhnghe;
  int? _uvnvNganhngheId;
  String? _uvnvVitrimongmuon;
  int? _uvnvVitrimongmuonId;
  String? _uvnvThoigian;
  int? _uvnvThoigianId;
  final _uvnvNoilamviecController = TextEditingController();
  int? _idMucluong;
  final _uvnvTienluong = TextEditingController();
  String? _uvnvHinhthuccongty;
  int? _uvnvHinhthuccongtyId;
  final _uvGhichuController = TextEditingController();
  String? _uvcmTrinhdo;
  int? _uvcmTrinhdoId;
  final _uvcmBangcapController = TextEditingController();
  final _uvcmKynangController = TextEditingController();
  final _uvcmTrinhdongoainguController = TextEditingController();
  final _uvcmTrinhdotinhocController = TextEditingController();
  final _uvcmKinhnghiem = TextEditingController();
  int? _uvSolanxem;
  int? _interview;
  int? _interviewed;
  bool? _uvDuyet;
  bool? _uvHienthi;
  bool? _uvhtTelephone;
  bool? _uvhtEmail;
  bool? _uvhtAddress;
  final _uvIdController = TextEditingController();
  bool? _newletterSubscription;
  bool? _jobsletterSubscription;
  bool? _coBhtn;
  final _soNhaDuongController = TextEditingController();
  int? _idThanhPho;
  final _idTinhController = TextEditingController();
  final _idHuyenController = TextEditingController();
  final _idXaController = TextEditingController();
  String? _idTv;
  String? _mahoGd;
  final _fileCVController = TextEditingController();
  int? _displayOrder;
  DateTime? _ngayduyet;
  String? _idNguonThuThap;
  final _avatarUrlController = TextEditingController();
  final _idBacHocController = TextEditingController();
  final _diachilienheController = TextEditingController();

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;

  // Model instance variables are kept for onChanged logic if needed by the page
  NguonThuThap? nguonThuThap;
  DanToc? danToc;
  TtTantat? tinhTrangTanTat;
  DoiTuong? doiTuongChinhSach;
  TinhThanhModel? tinhThanh;
  TinhThanhModel? tinhThanhmm;
  TrinhDoTinHoc? trinhDoTinHoc;
  TrinhDoNgoaiNgu? trinhDoNgoaiNgu;
  ChucDanhModel? chucDanh;
  MucLuongMM? mucLuong;
  ThoiGianLamViec? thoigianlamviec;
  HinhThucDoanhNghiep? hinhthucdoanhnghiep;
  TrinhDoVanHoa? trinhDoVanHoa;

  File? _selectedFile; // For file (e.g., CV)
  File? _selectedImage; // For image (e.g., avatar)

  @override
  void initState() {
    super.initState();
    final ntv = widget.hoSoUngVien;
    if (ntv != null) {
      // Basic Information
      _usernameController.text = ntv.uvUsername ?? '';
      _passwordController.text = ntv.uvPassword ?? '';
      _hotenController.text = ntv.uvHoten ?? '';
      _emailController.text = ntv.uvEmail ?? '';
      _maHoSoController.text = ntv.maHoSo ?? '';

      // Personal Information
      _uvGioitinh = ntv.uvGioitinh;
      _uvHonnhanId = ntv.uvHonnhanId;
      _uvngaysinhController = ntv.uvNgaysinh;
      _uvchieucaoController.text = ntv.uvChieucao ?? '';
      _uvcannangController.text = ntv.uvCannang ?? '';

      // Contact Information
      _diachichitietController.text = ntv.uvDiachichitiet ?? '';
      _dienthoaiController.text = ntv.uvDienthoai ?? '';
      _diachilienheController.text = ntv.diachilienhe ?? '';

      // ID Document Information
      _cmndController.text = ntv.uvSoCmnd ?? '';
      _uvNgaycap = ntv.uvNgaycap;
      _uvnoicapController.text = ntv.uvNoicap ?? '';

      // Location Information
      _idThanhPho = ntv.idThanhPho;
      _idTinhController.text = ntv.idTinh ?? '';
      _idHuyenController.text = ntv.idhuyen ?? '';
      _idXaController.text = ntv.idxa ?? '';

      // Work Experience and Skills
      _uvcmCongviechientaiController.text = ntv.uvcmCongviechientai ?? '';
      _uvcmKynangController.text = ntv.uvcmKynang ?? '';
      _uvcmKinhnghiem.text = ntv.uvcmKinhnghiem?.toString() ?? '';
      _cvMongMuonController.text = ntv.cvMongMuon ?? '';
      _uvnvTienluong.text = ntv.uvnvTienluong?.toString() ?? '';
      _uvGhichuController.text = ntv.uvGhichu ?? '';

      // IDs for Dropdowns
      _idDanToc = ntv.idDanToc;
      _uvTinhtrangtantatId = ntv.uvTinhtrangtantatId;
      _uvDoiTuongChingSachId = ntv.uvDoituongchinhsachId;
      _uvcmTrinhdoId = ntv.uvcmTrinhdoId;
      _uvnvNganhngheId = ntv.uvnvNganhngheId;
      _uvnvVitrimongmuonId = ntv.uvnvVitrimongmuonid;
      _uvnvThoigianId = ntv.uvnvThoigianId;
      _uvnvHinhthuccongtyId = ntv.uvnvHinhthuccongtyId;
      _idMucluong = ntv.idMucluong;

      // Education and Certificates
      _uvcmBangcapController.text = ntv.uvcmBangcap ?? '';
      _uvcmTrinhdongoainguController.text = ntv.uvcmTrinhdongoaingu ?? '';
      _uvcmTrinhdotinhocController.text = ntv.uvcmTrinhdotinhoc ?? '';
      _idBacHocController.text = ntv.idBacHoc ?? '';

      // Display Settings
      _uvDuyet = ntv.uvDuyet;
      _uvHienthi = ntv.uvHienthi;
      _uvhtTelephone = ntv.uvhtTelephone;
      _uvhtEmail = ntv.uvhtEmail;
      _uvhtAddress = ntv.uvhtAddress;

      // Subscription Settings
      _newletterSubscription = ntv.newsletterSubscription;
      _jobsletterSubscription = ntv.jobsletterSubscription;
      _coBhtn = ntv.coBhtn;

      // Files and Images
      _documentPathController.text = ntv.documentPath ?? '';
      _imagePathController.text = ntv.imagePath ?? '';
      _fileCVController.text = ntv.fileCv ?? '';
      _avatarUrlController.text = ntv.avatarUrl ?? '';

      // Initialize model instances from locator
      _initializeModelInstances(ntv);
    }
  }

  void _initializeModelInstances(TblHoSoUngVienModel ntv) {
    try {
      if (ntv.idNguonThuThap != null) {
        nguonThuThap = locator<List<NguonThuThap>>().firstWhere(
          (e) => e.id == ntv.idNguonThuThap,
          orElse: () => null as NguonThuThap,
        );
      }

      if (ntv.idDanToc != null) {
        danToc = locator<List<DanToc>>().firstWhere(
          (e) => e.id == ntv.idDanToc,
          orElse: () => null as DanToc,
        );
      }

      if (ntv.uvTinhtrangtantatId != null) {
        tinhTrangTanTat = locator<List<TtTantat>>().firstWhere(
          (e) => e.id == ntv.uvTinhtrangtantatId,
          orElse: () => null as TtTantat,
        );
      }

      if (ntv.uvDoituongchinhsachId != null) {
        doiTuongChinhSach = locator<List<DoiTuong>>().firstWhere(
          (e) => e.id == ntv.uvDoituongchinhsachId,
          orElse: () => null as DoiTuong,
        );
      }

      if (ntv.idThanhPho != null) {
        tinhThanh = locator<List<TinhThanhModel>>().firstWhere(
          (e) => e.id == ntv.idThanhPho,
          orElse: () => null as TinhThanhModel,
        );
      }

      if (ntv.uvnvNoilamviec != null && ntv.uvnvNoilamviec!.isNotEmpty) {
        final noiLamViecId = int.tryParse(ntv.uvnvNoilamviec!);
        if (noiLamViecId != null) {
          tinhThanhmm = locator<List<TinhThanhModel>>().firstWhere(
            (e) => e.id == noiLamViecId,
            orElse: () => null as TinhThanhModel,
          );
        }
      }
    } catch (e) {
      print('Error initializing model instances: $e');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Cập nhật thông tin',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 1.0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withAlpha(25),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: BlocListener<NTVBloc, NTVState>(
          bloc: locator<NTVBloc>(),
          listener: (context, state) {
            if (state is NTVLoaded) {
              Navigator.pop(context);
            }
            if (state is NTVError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is NTVUpdated) {
              ToastUtils.showToastSuccess(
                context,
                message: 'Cập nhật thành công',
                description: 'Test',
              );
              context.go('/ntv_home');
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                // Progress Indicator
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withAlpha(13),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(_steps.length, (index) {
                      return _buildStepIndicator(index);
                    }),
                  ),
                ),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withAlpha(13),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: _buildCurrentStep(),
                    ),
                  ),
                ),

                // Bottom Navigation
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int index) {
    final theme = Theme.of(context);
    bool isActive = index <= _currentStep;
    bool isCurrent = index == _currentStep;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Step number circle
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isCurrent
                  ? LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withAlpha(204),
                      ],
                    )
                  : null,
              color: isActive && !isCurrent
                  ? theme.colorScheme.primary.withAlpha(25)
                  : theme.colorScheme.surfaceVariant,
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withAlpha(33),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: isCurrent
                      ? theme.colorScheme.onPrimary
                      : isActive
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Step title
          Text(
            _steps[index],
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isCurrent
                  ? theme.colorScheme.primary
                  : isActive
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurfaceVariant,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return Step1PersonalInfo(
          formKey: _formKeys[0]!,
          emailController: _emailController,
          usernameController: _usernameController,
          passwordController: _passwordController,
          hotenController: _hotenController,
          dienthoaiController: _dienthoaiController,
          cmndController: _cmndController,
          uvnoicapController: _uvnoicapController,
          diachichitietController: _diachichitietController,
          uvchieucaoController: _uvchieucaoController,
          uvcannangController: _uvcannangController,
          idTinhController: _idTinhController,
          idHuyenController: _idHuyenController,
          idXaController: _idXaController,
          uvngaysinhController: _uvngaysinhController,
          uvNgaycap: _uvNgaycap,
          uvGioitinh: _uvGioitinh,
          uvHonnhanId: _uvHonnhanId,
          idDanToc: _idDanToc,
          uvTinhtrangtantatId: _uvTinhtrangtantatId,
          uvDoiTuongChingSachId: _uvDoiTuongChingSachId,
          idThanhPho: _idThanhPho,
          uvcmTrinhdoId: _uvcmTrinhdoId,
          idNguonThuThap: _idNguonThuThap != null
              ? int.tryParse(_idNguonThuThap.toString())
              : null,
          onNgaysinhChanged: (value) =>
              setState(() => _uvngaysinhController = value),
          onNgaycapChanged: (value) => setState(() => _uvNgaycap = value),
          onGioitinhChanged: (value) => setState(() => _uvGioitinh = value),
          onHonnhanChanged: (value) => setState(() => _uvHonnhanId = value),
          onNguonThuThapChanged: (value) => setState(() {
            _idNguonThuThap = value?.id;
            nguonThuThap = value;
          }),
          onDanTocChanged: (value) => setState(() {
            _idDanToc = value?.id;
            danToc = value;
          }),
          onTinhTrangTanTatChanged: (value) => setState(() {
            _uvTinhtrangtantatId = value?.id;
            tinhTrangTanTat = value;
          }),
          onDoiTuongChinhSachChanged: (value) => setState(() {
            _uvDoiTuongChingSachId = value?.id;
            doiTuongChinhSach = value;
          }),
          onThanhPhoChanged: (value) => setState(() {
            _idThanhPho = value?.id;
            tinhThanh = value;
          }),
          onTrinhDoVanHoaChanged: (value) => setState(() {
            _uvcmTrinhdoId = value?.id;
            trinhDoVanHoa = value;
          }),
          onLocationChanged: (tinh, huyen, xa) => setState(() {
            if (tinh != null) _idTinhController.text = tinh;
            if (huyen != null) _idHuyenController.text = huyen;
            if (xa != null) _idXaController.text = xa;
          }),
        );
      case 1:
        return Step2DisplaySettings(
          formKey: _formKeys[1]!,
          uvhtEmail: _uvhtEmail,
          uvhtAddress: _uvhtAddress,
          uvhtTelephone: _uvhtTelephone,
          newletterSubscription: _newletterSubscription,
          jobsletterSubscription: _jobsletterSubscription,
          selectedFile: _selectedFile,
          selectedImage: _selectedImage,
          onUvhtEmailChanged: (value) => setState(() => _uvhtEmail = value),
          onUvhtAddressChanged: (value) => setState(() => _uvhtAddress = value),
          onUvhtTelephoneChanged: (value) =>
              setState(() => _uvhtTelephone = value),
          onNewletterSubscriptionChanged: (value) =>
              setState(() => _newletterSubscription = value),
          onJobsletterSubscriptionChanged: (value) =>
              setState(() => _jobsletterSubscription = value),
          onPickFile: _pickFile,
          onPickImage: _pickImage,
        );
      case 2:
        return Step3JobPreferences(
          formKey: _formKeys[2]!,
          cvMongMuonController: _cvMongMuonController,
          uvnvTienluong: _uvnvTienluong,
          uvcmCongviechientaiController: _uvcmCongviechientaiController,
          uvcmKynangController: _uvcmKynangController,
          uvGhichuController: _uvGhichuController,
          uvnvNoilamviecController: _uvnvNoilamviecController,
          uvnvVitrimongmuonId: _uvnvVitrimongmuonId,
          idMucluong: _idMucluong,
          uvnvThoigianId: _uvnvThoigianId,
          uvnvHinhthuccongtyId: _uvnvHinhthuccongtyId,
          onChucDanhChanged: (value) => setState(() {
            chucDanh = value;
            _uvnvVitrimongmuonId = value?.id;
          }),
          onMucLuongChanged: (value) => setState(() {
            _idMucluong = value?.id;
            mucLuong = value;
          }),
          onThoiGianLamViecChanged: (value) => setState(() {
            _uvnvThoigianId = value?.id;
            thoigianlamviec = value;
          }),
          onHinhThucDoanhNghiepChanged: (value) => setState(() {
            _uvnvHinhthuccongtyId = value?.id;
            hinhthucdoanhnghiep = value;
          }),
          onTinhThanhMMChanged: (value) => setState(() {
            _uvnvNoilamviecController.text = value?.id.toString() ?? '';
            tinhThanhmm = value;
          }),
        );
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigation() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _currentStep--;
                });
              },
              icon: Icon(Icons.arrow_back, size: 14),
              label: Text(
                'Quay lại',
                style: theme.textTheme.labelMedium,
              ),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
            )
          else
            const SizedBox(width: 85),
          ElevatedButton.icon(
            onPressed: () {
              final currentFormKey = _formKeys[_currentStep];
              if (currentFormKey?.currentState?.validate() ?? false) {
                currentFormKey?.currentState?.save();
                if (_currentStep < _steps.length - 1) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  _submitForm();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Vui lòng điền đầy đủ thông tin bắt buộc',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onError,
                      ),
                    ),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              }
            },
            icon: Icon(
              _currentStep == _steps.length - 1
                  ? Icons.check
                  : Icons.arrow_forward,
              size: 14,
            ),
            label: Text(
              _currentStep == _steps.length - 1 ? 'Hoàn thành' : 'Tiếp tục',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKeys[_currentStep]?.currentState?.validate() ?? false) {
      final ntvBloc = locator<NTVBloc>();
      if (ntvBloc.state is NTVLoadedById) {
        final originalNtv = (ntvBloc.state as NTVLoadedById).tblHoSoUngVien;
        if (originalNtv != null) {
          final updatedNtv = TblHoSoUngVienModel(
            id: originalNtv.id,
            uvUsername: _usernameController.text,
            uvPassword: _passwordController.text,
            uvHoten: _hotenController.text,
            uvEmail: _emailController.text,
            maHoSo: 'Test',
            cvMongMuon: _cvMongMuonController.text,
            documentPath: 'Test',
            imagePath: 'Test',
            uvDiachichitiet: _diachichitietController.text,
            uvDienthoai: _dienthoaiController.text,
            uvSoCmnd: _cmndController.text,
            uvNgaycap: _uvNgaycap,
            uvNoicap: _uvnoicapController.text,
            uvGioitinh: _uvGioitinh,
            uvChieucao: _uvchieucaoController.text,
            uvCannang: _uvcannangController.text,
            idNguonThuThap: _idNguonThuThap,
            uvNgaysinh: _uvngaysinhController,
            uvcmCongviechientai: _uvcmCongviechientaiController.text,
            uvnvNoilamviec: _uvnvNoilamviecController.text,
            diachilienhe: _diachilienheController.text,
            uvnvTienluong: double.tryParse(_uvnvTienluong.text) ?? 0,
            uvGhichu: _uvGhichuController.text,
            uvcmBangcap: _uvcmBangcapController.text,
            uvcmKynang: _uvcmKynangController.text,
            uvcmTrinhdongoaingu: _uvcmTrinhdongoainguController.text,
            uvcmTrinhdotinhoc: _uvcmTrinhdotinhocController.text,
            uvcmKinhnghiem: int.tryParse(_uvcmKinhnghiem.text) ?? 0,
            uvDuyet: _uvDuyet,
            uvHienthi: _uvHienthi,
            uvhtTelephone: _uvhtTelephone,
            uvhtEmail: _uvhtEmail,
            uvhtAddress: _uvhtAddress,
            uvId: _uvIdController.text,
            newsletterSubscription: _newletterSubscription,
            jobsletterSubscription: _jobsletterSubscription,
            coBhtn: _coBhtn ?? false,
            soNhaDuong: _soNhaDuongController.text,
            idThanhPho: _idThanhPho,
            idTinh: _idTinhController.text,
            idhuyen: _idHuyenController.text,
            idxa: _idXaController.text,
            idtv: _idTv,
            idBacHoc: _idBacHocController.text,
            idMucluong: _idMucluong,
            mahoGd: _mahoGd,
            displayOrder: _displayOrder,
            ngayduyet: _ngayduyet,
            uvTinhtrangtantatId: _uvTinhtrangtantatId ?? 0,
            idDanToc: _idDanToc ?? 0,
            uvHonnhanId: _uvHonnhanId,
            uvnvVitrimongmuonid: _uvnvVitrimongmuonId ?? 0,
            uvDoituongchinhsachId: _uvDoiTuongChingSachId ?? 0,
            uvcmTrinhdoId: _uvcmTrinhdoId ?? 0,
            uvnvNganhngheId: _uvnvNganhngheId ?? 0,
            uvnvHinhthuccongtyId: _uvnvHinhthuccongtyId ?? 0,
            uvnvThoigianId: _uvnvThoigianId ?? 0,
            fileCv: _selectedFile?.path ?? originalNtv.fileCv,
            avatarUrl: _selectedImage?.path ?? originalNtv.avatarUrl,
          );
          FormData formData = FormData.fromMap({
            'id': originalNtv.id,
            'uvUsername': _usernameController.text,
            'uvPassword': _passwordController.text,
            'uvHoten': _hotenController.text,
            'uvEmail': _emailController.text,
            'maHoSo': 'Test',
            'cvMongMuon': _cvMongMuonController.text,
            'documentPath': 'Test',
            'imagePath': 'Test',
            'uvDiachichitiet': _diachichitietController.text,
            'uvDienthoai': _dienthoaiController.text,
            'uvSoCmnd': _cmndController.text,
            'uvNgaycap': _uvNgaycap,
            'uvNoicap': _uvnoicapController.text,
            'uvGioitinh': _uvGioitinh,
            'uvChieucao': _uvchieucaoController.text,
            'uvCannang': _uvcannangController.text,
            'idNguonThuThap': _idNguonThuThap,
            'uvNgaysinh': _uvngaysinhController,
            'uvcmCongviechientai': _uvcmCongviechientaiController.text,
            'uvnvNoilamviec': _uvnvNoilamviecController.text,
            'diachilienhe': _diachilienheController.text,
            'uvnvTienluong': double.tryParse(_uvnvTienluong.text) ?? 0,
            'uvGhichu': _uvGhichuController.text,
            'uvcmBangcap': _uvcmBangcapController.text,
            'uvcmKynang': _uvcmKynangController.text,
            'uvcmTrinhdongoaingu': _uvcmTrinhdongoainguController.text,
            'uvcmTrinhdotinhoc': _uvcmTrinhdotinhocController.text,
            'uvcmKinhnghiem': int.tryParse(_uvcmKinhnghiem.text) ?? 0,
            'uvDuyet': _uvDuyet,
            'uvHienthi': _uvHienthi,
            'uvhtTelephone': _uvhtTelephone,
            'uvhtEmail': _uvhtEmail,
            'uvhtAddress': _uvhtAddress,
            'uvId': _uvIdController.text,
            'newsletterSubscription': _newletterSubscription,
            'jobsletterSubscription': _jobsletterSubscription,
            'coBhtn': _coBhtn ?? false,
            'soNhaDuong': _soNhaDuongController.text,
            'idThanhPho': _idThanhPho,
            'idTinh': _idTinhController.text,
            'idhuyen': _idHuyenController.text,
            'idxa': _idXaController.text,
            'idtv': _idTv,
            'idBacHoc': _idBacHocController.text,
            'idMucluong': _idMucluong,
            'mahoGd': _mahoGd,
            'displayOrder': _displayOrder,
            'ngayduyet': _ngayduyet,
            'uvTinhtrangtantatId': _uvTinhtrangtantatId ?? 0,
            'idDanToc': _idDanToc ?? 0,
            'uvHonnhanId': _uvHonnhanId,
            'uvnvVitrimongmuonid': _uvnvVitrimongmuonId ?? 0,
            'uvDoituongchinhsachId': _uvDoiTuongChingSachId ?? 0,
            'uvcmTrinhdoId': _uvcmTrinhdoId ?? 0,
            'uvnvNganhngheId': _uvnvNganhngheId ?? 0,
            'uvnvHinhthuccongtyId': _uvnvHinhthuccongtyId ?? 0,
            'uvnvThoigianId': _uvnvThoigianId ?? 0,
            'fileCv': _selectedFile?.path ?? originalNtv.fileCv,
            'avatarUrl': _selectedImage?.path ?? originalNtv.avatarUrl,
            if (_selectedFile != null)
              'CV': await MultipartFile.fromFile(
                _selectedFile!.path,
                filename: _selectedFile!.path.split('/').last,
                contentType: MediaType('application', 'pdf'),
              ),
            if (_selectedImage != null)
              'avatar': await MultipartFile.fromFile(
                _selectedImage!.path,
                filename: _selectedImage!.path.split('/').last,
                contentType: MediaType('image', 'png'),
              ),
          });
          if (!mounted) return;
          locator<NTVBloc>().add(UpdateTblHoSoUngVien(updatedNtv.id, formData));
        } else {
          print("Invalid state: ${ntvBloc.state}");
        }
      } else {
        print("Form validation failed");
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _hotenController.dispose();
    _emailController.dispose();
    _maHoSoController.dispose();
    _cvMongMuonController.dispose();
    _documentPathController.dispose();
    _imagePathController.dispose();
    _diachichitietController.dispose();
    _dienthoaiController.dispose();
    _cmndController.dispose();
    _uvnoicapController.dispose();
    _uvcmCongviechientaiController.dispose();
    _uvnvNoilamviecController.dispose();
    _uvGhichuController.dispose();
    _uvcmBangcapController.dispose();
    _uvcmKynangController.dispose();
    _uvcmTrinhdongoainguController.dispose();
    _uvcmTrinhdotinhocController.dispose();
    _uvIdController.dispose();
    _soNhaDuongController.dispose();
    _idTinhController.dispose();
    _idHuyenController.dispose();
    _idXaController.dispose();
    _fileCVController.dispose();
    _idBacHocController.dispose();
    _diachilienheController.dispose();
    super.dispose();
  }
}
