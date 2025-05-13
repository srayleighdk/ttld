import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/models/trinh_do_van_hoa_model.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/widgets/cascade_location_picker.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

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
    3: GlobalKey<FormState>(),
  };
  int _currentStep = 0;
  final List<String> _steps = [
    'Thông tin\ncá nhân',
    'Hiện thị\nthông tin',
    'Việc làm\nmong muốn',
    'Xác nhận',
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
  // TrinhDoHocVan? trinhDoHocVan; // This was unused
  TrinhDoTinHoc? trinhDoTinHoc;
  TrinhDoNgoaiNgu? trinhDoNgoaiNgu;
  // NganhNgheKT? nganhNghe; // This was unused
  TrinhDoChuyenMon? nganhNgheBacHoc;
  NganhNgheTD? nganhNgheTD;
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
    // final ntvBloc = BlocProvider.of<NTVBloc>(context);
    // print('ntvBloc: ${ntvBloc.state}');

    // if (ntvBloc.state is NTVLoadedById || widget.hoSoUngVien != null) {
    final ntv = widget.hoSoUngVien;
    if (ntv != null) {
      _usernameController.text = ntv.uvUsername ?? '';
      _passwordController.text = ntv.uvPassword ?? '';
      _hotenController.text = ntv.uvHoten ?? '';
      _emailController.text = ntv.uvEmail ?? '';
      _maHoSoController.text = ntv.maHoSo ?? '';
      _idDanToc = ntv.idDanToc;
      _cvMongMuonController.text = ntv.cvMongMuon ?? '';
      _documentPathController.text = ntv.documentPath ?? '';
      _imagePathController.text = ntv.imagePath ?? '';
      _diachichitietController.text = ntv.uvDiachichitiet ?? '';
      _dienthoaiController.text = ntv.uvDienthoai ?? '';
      _cmndController.text = ntv.uvSoCmnd ?? '';
      _uvNgaycap = ntv.uvNgaycap;
      _uvnoicapController.text = ntv.uvNoicap ?? '';
      _uvGioitinh = ntv.uvGioitinh;
      _uvchieucaoController.text = ntv.uvChieucao ?? '';
      _uvcannangController.text = ntv.uvCannang ?? '';
      _uvDoiTuongChingSach = ntv.uvDoituongchinhsachId.toString();
      _uvTinhtrangtantat = ntv.uvTinhtrangtantatId.toString();
      _uvHonnhanId = ntv.uvHonnhanId;
      _uvngaysinhController = ntv.uvNgaysinh;
      _uvcmCongviechientaiController.text = ntv.uvcmCongviechientai ?? '';
      _uvnvNganhnghe = ntv.uvnvNganhngheId.toString();
      _uvnvVitrimongmuon = ntv.uvnvVitrimongmuonid.toString();
      _uvnvThoigian = ntv.uvnvThoigianId.toString();
      _uvnvNoilamviecController.text = ntv.uvnvNoilamviec ?? '';
      _idMucluong = ntv.idMucluong;
      _uvnvTienluong.text = ntv.uvnvTienluong?.toString() ?? '';
      _uvnvHinhthuccongty = ntv.uvnvHinhthuccongtyId.toString();
      _uvGhichuController.text = ntv.uvGhichu ?? '';
      _uvcmTrinhdo = ntv.uvcmTrinhdoId.toString();
      _uvcmBangcapController.text = ntv.uvcmBangcap ?? '';
      _uvcmKynangController.text = ntv.uvcmKynang ?? '';
      _uvcmTrinhdongoainguController.text = ntv.uvcmTrinhdongoaingu ?? '';
      _uvcmTrinhdotinhocController.text = ntv.uvcmTrinhdotinhoc ?? '';
      _uvcmKinhnghiem.text = ntv.uvcmKinhnghiem?.toString() ?? '';
      _uvSolanxem = ntv.uvSolanxem;
      _interview = ntv.interview;
      _interviewed = ntv.interviewed;
      _uvDuyet = ntv.uvDuyet;
      _uvHienthi = ntv.uvHienthi;
      _uvhtTelephone = ntv.uvhtTelephone;
      _uvhtEmail = ntv.uvhtEmail;
      _uvhtAddress = ntv.uvhtAddress;
      _uvIdController.text = ntv.uvId.toString();
      _newletterSubscription = ntv.newsletterSubscription;
      _jobsletterSubscription = ntv.jobsletterSubscription;
      _coBhtn = ntv.coBhtn;
      _soNhaDuongController.text = ntv.soNhaDuong ?? '';
      _idThanhPho = ntv.idThanhPho;
      _idTinhController.text = ntv.idTinh ?? '';
      _idHuyenController.text = ntv.idhuyen ?? '';
      _idXaController.text = ntv.idxa ?? '';
      _idTv = ntv.idtv;
      _mahoGd = ntv.mahoGd;
      _fileCVController.text = ntv.fileCv ?? '';
      _displayOrder = ntv.displayOrder;
      _ngayduyet = ntv.ngayduyet;
      _idNguonThuThap = ntv.idNguonThuThap;
      _avatarUrlController.text = ntv.avatarUrl ?? '';
      _idBacHocController.text = ntv.idBacHoc ?? '';
      _diachilienheController.text = ntv.diachilienhe ?? '';
      _uvTinhtrangtantatId = ntv.uvTinhtrangtantatId;
      _uvDoiTuongChingSachId = ntv.uvDoituongchinhsachId;
      _uvcmTrinhdoId = ntv.uvcmTrinhdoId;
      _uvnvNganhngheId = ntv.uvnvNganhngheId;
      _uvnvVitrimongmuonId = ntv.uvnvVitrimongmuonid;
      _uvnvThoigianId = ntv.uvnvThoigianId;
      _uvnvHinhthuccongtyId = ntv.uvnvHinhthuccongtyId;
    }
    // }

    // if (ntvBloc.state is NTVError) {
    //   print('Error message: ${(ntvBloc.state as NTVError).message}');
    // }
    // Data for GenericPickers will be fetched via locator directly in the items prop.
    // Initialize model instances if needed based on existing IDs after widget.hoSoUngVien is processed.
    // This part might require adjustment if initial selection logic was heavily tied to _load methods.
    // GenericPicker itself will handle finding the item from locator<List<T>>() using initialValue.

    // Example of how you might re-initialize selected models if needed,
    // assuming locator provides data synchronously or GenericPicker handles async loading:
    if (widget.hoSoUngVien != null) {
      final ntv = widget.hoSoUngVien!;
      if (ntv.idNguonThuThap != null)
        nguonThuThap = locator<List<NguonThuThap>>().firstWhere(
            (e) => e.id == ntv.idNguonThuThap,
            orElse: () => null as NguonThuThap);
      if (ntv.idDanToc != null)
        danToc = locator<List<DanToc>>().firstWhere((e) => e.id == ntv.idDanToc,
            orElse: () => null as DanToc);
      if (ntv.uvTinhtrangtantatId != null)
        tinhTrangTanTat = locator<List<TtTantat>>().firstWhere(
            (e) => e.id == ntv.uvTinhtrangtantatId,
            orElse: () => null as TtTantat);
      if (ntv.uvDoituongchinhsachId != null)
        doiTuongChinhSach = locator<List<DoiTuong>>().firstWhere(
            (e) => e.id == ntv.uvDoituongchinhsachId,
            orElse: () => null as DoiTuong);
      if (ntv.idThanhPho != null)
        tinhThanh = locator<List<TinhThanhModel>>().firstWhere(
            (e) => e.id == ntv.idThanhPho,
            orElse: () => null as TinhThanhModel);
      if (ntv.uvnvNoilamviec != null && ntv.uvnvNoilamviec!.isNotEmpty)
        tinhThanhmm = locator<List<TinhThanhModel>>().firstWhere(
            (e) => e.id == int.tryParse(ntv.uvnvNoilamviec!),
            orElse: () => null as TinhThanhModel);
      if (ntv.uvcmTrinhdotinhoc != null && ntv.uvcmTrinhdotinhoc!.isNotEmpty)
        trinhDoTinHoc = locator<List<TrinhDoTinHoc>>().firstWhere(
            (e) => e.id == ntv.uvcmTrinhdotinhoc,
            orElse: () => null as TrinhDoTinHoc);
      if (ntv.uvcmTrinhdongoaingu != null &&
          ntv.uvcmTrinhdongoaingu!.isNotEmpty)
        trinhDoNgoaiNgu = locator<List<TrinhDoNgoaiNgu>>().firstWhere(
            (e) => e.id == ntv.uvcmTrinhdongoaingu,
            orElse: () => null as TrinhDoNgoaiNgu);
      if (ntv.idBacHoc != null && ntv.idBacHoc!.isNotEmpty)
        nganhNgheBacHoc = locator<List<TrinhDoChuyenMon>>().firstWhere(
            (e) => e.id == ntv.idBacHoc,
            orElse: () => null as TrinhDoChuyenMon);
      if (ntv.uvnvNganhngheId != null)
        nganhNgheTD = locator<List<NganhNgheTD>>().firstWhere(
            (e) => e.id == ntv.uvnvNganhngheId,
            orElse: () => null as NganhNgheTD);
      if (ntv.uvnvVitrimongmuonid != null)
        chucDanh = locator<List<ChucDanhModel>>().firstWhere(
            (e) => e.id == ntv.uvnvVitrimongmuonid,
            orElse: () => null as ChucDanhModel);
      if (ntv.idMucluong != null)
        mucLuong = locator<List<MucLuongMM>>().firstWhere(
            (e) => e.id == ntv.idMucluong,
            orElse: () => null as MucLuongMM);
      if (ntv.uvnvThoigianId != null)
        thoigianlamviec = locator<List<ThoiGianLamViec>>().firstWhere(
            (e) => e.id == ntv.uvnvThoigianId,
            orElse: () => null as ThoiGianLamViec);
      if (ntv.uvnvHinhthuccongtyId != null)
        hinhthucdoanhnghiep = locator<List<HinhThucDoanhNghiep>>().firstWhere(
            (e) => e.id == ntv.uvnvHinhthuccongtyId,
            orElse: () => null as HinhThucDoanhNghiep);
      if (ntv.uvcmTrinhdoId != null)
        trinhDoVanHoa = locator<List<TrinhDoVanHoa>>().firstWhere(
            (e) => e.id == ntv.uvcmTrinhdoId,
            orElse: () => null as TrinhDoVanHoa);
    }
  }

// Data loading functions are removed as GenericPickers will use locator directly.

// Pick a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'], // Restrict to specific types
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  // Pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Or ImageSource.camera
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
                  padding: const EdgeInsets.symmetric(vertical: 8), // Reduced padding
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
                    padding: const EdgeInsets.all(24),
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
                      padding: const EdgeInsets.all(24),
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
            width: 28, // Reduced size
            height: 28, // Reduced size
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
          const SizedBox(height: 4), // Reduced spacing
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
        return buildStep1();
      case 1:
        return buildStep2();
      case 2:
        return buildStep3();
      case 3:
        return _buildConfirmationForm();
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigation() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, -4),
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
              icon: Icon(Icons.arrow_back, size: 18),
              label: Text('Quay lại'),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
            )
          else
            const SizedBox(width: 120),
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
                    content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              }
            },
            icon: Icon(
              _currentStep == _steps.length - 1
                  ? Icons.check
                  : Icons.arrow_forward,
              size: 18,
            ),
            label: Text(
              _currentStep == _steps.length - 1 ? 'Hoàn thành' : 'Tiếp tục',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
      ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(theme, title),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildStep1() {
    final theme = Theme.of(context);
    return Form(
      key: _formKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Thông tin tài khoản',
            [
              CustomTextField.email(
                controller: _emailController,
                validator: 'email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Tên đăng nhập',
                hintText: 'Tên đăng nhập',
                controller: _usernameController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 16),
              CustomTextField.password(
                controller: _passwordController,
                validator: 'not_empty',
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin cá nhân',
            [
              CustomTextField(
                labelText: 'Họ và tên',
                hintText: 'Họ và tên',
                controller: _hotenController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 16),
              CustomPickDateTimeGrok(
                hintText: 'Ngày sinh',
                initialValue: _uvngaysinhController,
                validator: (DateTime? value) {
                  if (value == null) {
                    return 'Ngày sinh không được để trống';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    _uvngaysinhController = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<NguonThuThap>(
                label: 'Nguồn thu thập',
                items: locator<List<NguonThuThap>>(),
                initialValue: _idNguonThuThap,
                onChanged: (NguonThuThap? value) {
                  setState(() {
                    _idNguonThuThap = value?.id;
                    nguonThuThap = value;
                  });
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin chi tiết',
            [
              Row(
                children: [
                  Expanded(
                    child: CustomPickerMap(
                      label: Text('Giới tính'),
                      items: gioiTinhOptions,
                      selectedItem: _uvGioitinh,
                      onChanged: (gioiTinh) {
                        setState(() {
                          _uvGioitinh = gioiTinh;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomPickerMap(
                      label: Text('Hôn nhân'),
                      items: hoNhanOptions,
                      selectedItem: _uvHonnhanId,
                      onChanged: (hoNhan) {
                        setState(() {
                          _uvHonnhanId = hoNhan;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Số CCCD',
                controller: _cmndController,
                validator: 'not_empty',
                hintText: 'Số CCCD',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomPickDateTimeGrok(
                      initialValue: _uvNgaycap,
                      onChanged: (value) {
                        setState(() {
                          _uvNgaycap = value;
                        });
                      },
                      hintText: 'Ngày cấp',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Nơi cấp',
                      hintText: 'Nơi cấp',
                      controller: _uvnoicapController,
                      validator: 'not_empty',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Số điện thoại',
                hintText: 'Số điện thoại',
                controller: _dienthoaiController,
                validator: 'not_empty',
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin bổ sung',
            [
              GenericPicker<DanToc>(
                label: 'Dân Tộc',
                items: locator<List<DanToc>>(),
                initialValue: _idDanToc,
                onChanged: (DanToc? value) {
                  setState(() {
                    _idDanToc = value?.id;
                    danToc = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TtTantat>(
                label: 'Tình trạng tàn tật',
                items: locator<List<TtTantat>>(),
                initialValue: _uvTinhtrangtantatId,
                onChanged: (TtTantat? value) {
                  setState(() {
                    _uvTinhtrangtantatId = value?.id;
                    tinhTrangTanTat = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<DoiTuong>(
                label: 'Đối tượng chính sách',
                items: locator<List<DoiTuong>>(),
                initialValue: _uvDoiTuongChingSachId,
                onChanged: (DoiTuong? value) {
                  setState(() {
                    _uvDoiTuongChingSachId = value?.id;
                    doiTuongChinhSach = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Chiều cao (cm)',
                      hintText: 'Chiều cao (cm)',
                      controller: _uvchieucaoController,
                      validator: 'not_empty',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Cân nặng (kg)',
                      hintText: 'Cân nặng (kg)',
                      controller: _uvcannangController,
                      validator: 'not_empty',
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Địa chỉ',
            [
              CascadeLocationPicker(
                initialTinh: _idTinhController.text,
                initialHuyen: _idHuyenController.text,
                initialXa: _idXaController.text,
                onTinhChanged: (tinh) {
                  setState(() {
                    _selectedTinh = tinh?.tentinh;
                    _idTinhController.text = tinh?.matinh ?? '';
                  });
                },
                onHuyenChanged: (huyen) {
                  setState(() {
                    _selectedHuyen = huyen?.tenhuyen;
                    _idHuyenController.text = huyen?.mahuyen ?? '';
                  });
                },
                onXaChanged: (xa) {
                  setState(() {
                    _selectedXa = xa?.tenxa;
                    _idXaController.text = xa?.maxa ?? '';
                  });
                },
                isNTD: false,
                addressDetailController: _diachichitietController,
              ),
              const SizedBox(height: 16),
              GenericPicker<TinhThanhModel>(
                label: 'Thành phố nơi làm việc',
                items: locator<List<TinhThanhModel>>(),
                initialValue: _idThanhPho,
                onChanged: (TinhThanhModel? value) {
                  setState(() {
                    _idThanhPho = value?.id;
                    tinhThanh = value;
                  });
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Trình độ chuyên môn',
            [
              GenericPicker<TrinhDoVanHoa>(
                label: 'Trình độ văn hóa',
                items: locator<List<TrinhDoVanHoa>>(),
                initialValue: _uvcmTrinhdoId,
                onChanged: (TrinhDoVanHoa? value) {
                  setState(() {
                    _uvcmTrinhdoId = value?.id;
                    trinhDoVanHoa = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<NganhNgheTD>(
                label: 'Ngành nghề',
                items: locator<List<NganhNgheTD>>(),
                initialValue: _uvnvNganhngheId,
                onChanged: (NganhNgheTD? value) {
                  setState(() {
                    _uvnvNganhngheId = value?.id;
                    nganhNgheTD = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoChuyenMon>(
                label: 'Trình độ chuyên môn',
                items: locator<List<TrinhDoChuyenMon>>(),
                initialValue: _idBacHocController.text,
                onChanged: (TrinhDoChuyenMon? value) {
                  setState(() {
                    _idBacHocController.text = value?.id.toString() ?? '';
                    nganhNgheBacHoc = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField.number(
                labelText: 'Kinh nghiệm',
                hintText: 'Kinh nghiệm (tháng)',
                controller: _uvcmKinhnghiem,
                validator: 'not_empty',
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Kỹ năng',
            [
              GenericPicker<TrinhDoNgoaiNgu>(
                label: 'Trình độ ngoại ngữ',
                items: locator<List<TrinhDoNgoaiNgu>>(),
                initialValue: _uvcmTrinhdongoainguController.text,
                onChanged: (TrinhDoNgoaiNgu? value) {
                  setState(() {
                    _uvcmTrinhdongoainguController.text =
                        value?.id.toString() ?? '';
                    trinhDoNgoaiNgu = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TrinhDoTinHoc>(
                label: 'Trình độ tin học',
                items: locator<List<TrinhDoTinHoc>>(),
                initialValue: _uvcmTrinhdotinhocController.text,
                onChanged: (TrinhDoTinHoc? value) {
                  setState(() {
                    _uvcmTrinhdotinhocController.text =
                        value?.id.toString() ?? '';
                    trinhDoTinHoc = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Bằng cấp khác',
                hintText: 'Bằng cấp khác',
                controller: _uvcmBangcapController,
              ),
              const SizedBox(height: 16),
              CustomCheckbox(
                label: 'Có Bảo Hiểm thất nghiệp',
                value: _coBhtn ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _coBhtn = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStep2() {
    final theme = Theme.of(context);
    return Form(
      key: _formKeys[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Hiển thị thông tin',
            [
              CustomCheckbox(
                label: 'Email',
                value: _uvhtEmail ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _uvhtEmail = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              CustomCheckbox(
                label: 'Địa chỉ',
                value: _uvhtAddress ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _uvhtAddress = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              CustomCheckbox(
                label: 'Số điện thoại',
                value: _uvhtTelephone ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _uvhtTelephone = value;
                  });
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Đăng ký nhận thông báo',
            [
              CustomCheckbox(
                label: 'Đăng ký nhận bản tin',
                value: _newletterSubscription ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _newletterSubscription = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              CustomCheckbox(
                label: 'Đăng ký nhận thông báo việc làm',
                value: _jobsletterSubscription ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _jobsletterSubscription = value;
                  });
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Tài liệu đính kèm',
            [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CV của bạn',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedFile != null
                                ? _selectedFile!.path.split('/').last
                                : 'Chưa chọn file',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: Icon(Icons.upload_file, size: 18),
                          label: Text('Chọn File CV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ảnh đại diện',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (_selectedImage != null)
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              size: 40,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _pickImage,
                                icon: Icon(Icons.photo_library, size: 18),
                                label: Text('Chọn Ảnh'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              if (_selectedImage != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  _selectedImage!.path.split('/').last,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStep3() {
    final theme = Theme.of(context);
    return Form(
      key: _formKeys[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Việc làm mong muốn',
            [
              CustomTextField(
                labelText: 'Việc làm mong muốn',
                hintText: 'Việc làm mong muốn',
                controller: _cvMongMuonController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 16),
              GenericPicker<ChucDanhModel>(
                label: 'Chức vụ mong muốn',
                items: locator<List<ChucDanhModel>>(),
                initialValue: _uvnvVitrimongmuonId,
                onChanged: (ChucDanhModel? value) {
                  setState(() {
                    chucDanh = value;
                    _uvnvVitrimongmuonId = value?.id;
                  });
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin lương',
            [
              GenericPicker<MucLuongMM>(
                label: 'Mức lương mong muốn',
                items: locator<List<MucLuongMM>>(),
                initialValue: _idMucluong,
                onChanged: (MucLuongMM? value) {
                  setState(() {
                    _idMucluong = value?.id;
                    mucLuong = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField.number(
                allowDecimals: true,
                hintText: 'Lương khởi điểm',
                controller: _uvnvTienluong,
                validator: 'not_empty',
                labelText: 'Lương khởi điểm',
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thời gian và hình thức làm việc',
            [
              GenericPicker<ThoiGianLamViec>(
                label: 'Thời gian làm việc mong muốn',
                items: locator<List<ThoiGianLamViec>>(),
                initialValue: _uvnvThoigianId,
                onChanged: (ThoiGianLamViec? value) {
                  setState(() {
                    _uvnvThoigianId = value?.id;
                    thoigianlamviec = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<HinhThucDoanhNghiep>(
                label: 'Hình thức công ty mong muốn',
                items: locator<List<HinhThucDoanhNghiep>>(),
                initialValue: _uvnvHinhthuccongtyId,
                onChanged: (HinhThucDoanhNghiep? value) {
                  setState(() {
                    _uvnvHinhthuccongtyId = value?.id;
                    hinhthucdoanhnghiep = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              GenericPicker<TinhThanhModel>(
                label: 'Thành phố mong muốn',
                items: locator<List<TinhThanhModel>>(),
                initialValue: _uvnvNoilamviecController.text,
                onChanged: (TinhThanhModel? value) {
                  setState(() {
                    _uvnvNoilamviecController.text = value?.id.toString() ?? '';
                    tinhThanhmm = value;
                  });
                },
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Kinh nghiệm và kỹ năng',
            [
              CustomTextField.textArea(
                labelText: 'Công việc đã làm',
                hintText: 'Công việc đã làm',
                minLines: 3,
                maxLines: 5,
                controller: _uvcmCongviechientaiController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                labelText: 'Kỹ năng',
                hintText: 'Kỹ năng',
                minLines: 3,
                maxLines: 5,
                controller: _uvcmKynangController,
              ),
              const SizedBox(height: 16),
              CustomTextField.textArea(
                labelText: 'Ghi chú',
                hintText: 'Ghi chú',
                minLines: 3,
                maxLines: 5,
                controller: _uvGhichuController,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationForm() {
    return Form(
      key: _formKeys[3],
      child: Column(
        children: [
          // Display summary of entered information
          Text('Họ tên: ${_hotenController.text}'),
          Text('Email: ${_emailController.text}'),
          // Add other summary fields...
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Xác nhận và Lưu'),
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

            // uvnvThoigian: thoigianlamviec?.name ?? '',
            // tenDanToc: danToc?.name ?? '',
            // uvTinhtrangtantat: tinhTrangTanTat?.name ?? '',
            // uvHonnhan: hoNhanOptions[false],
            // uvnvNganhnghe: nganhNgheTD?.name ?? '',
            // uvnvVitrimongmuon: chucDanh?.name ?? '',
            // uvnvHinhthuccongty: hinhthucdoanhnghiep?.name ?? '',
            // uvcmTrinhdo: trinhDoHocVan?.name ?? '',
            // uvSolanxem: _uvSolanxem,
            // avatarUrl: _avatarUrlController.text ?? 'Test',
            // uvDoituongchinhsach: doiTuongChinhSach?.name ?? '',
            // avatar: _avatarUrlController.text ?? 'Test',
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
          if (!mounted) return; // Prevent action if widget is disposed
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
