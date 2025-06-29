import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/models/loai_hinh_model.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/thoigian_hoatdong.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/account_info_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/contact_info_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/company_info_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/status_and_activity_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/company_type_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/location_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/contact_details_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/display_settings_section.dart';
import 'package:ttld/pages/home/ntd/update_ntd/widgets/notification_settings_section.dart';

class UpdateNTDPage extends StatefulWidget {
  static const routePath = '/update_ntd';
  const UpdateNTDPage({super.key});

  @override
  _UpdateNTDPageState createState() => _UpdateNTDPageState();
}

class _UpdateNTDPageState extends State<UpdateNTDPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ntdMadnController = TextEditingController();
  final _ntdTentatController = TextEditingController();
  final _imagePathController = TextEditingController();
  final _ntdTenController = TextEditingController();
  final _mstController = TextEditingController();
  final _ntdSolaodongController = TextEditingController();
  final _ntdGioithieuController = TextEditingController();
  final _ntdThuockhucongnghiepController = TextEditingController();
  final _ntdDiachithanhphoController = TextEditingController();
  final _ntdDiachihuyenController = TextEditingController();
  final _ntdDiachixaphuongController = TextEditingController();
  final _ntdDiachichitietController = TextEditingController();
  final _ntdNguoilienheController = TextEditingController();
  final _ntdDienthoaiController = TextEditingController();
  final _ntdFaxController = TextEditingController();
  final _ntdEmailController = TextEditingController();
  final _ntdWebsiteController = TextEditingController();

  bool _ntdDuyet = false;
  bool _ntdTopbloc = false;

  final _ntdNamthanhlapController = TextEditingController();
  final _ntdLinhvuchoatdongController = TextEditingController();

  bool _ntdhtNlh = false;
  bool _ntdhtTelephone = false;
  bool _ntdhtWeb = false;
  bool _ntdhtFax = false;
  bool _ntdhtEmail = false;
  bool _ntdhtAddress = false;

  final _ntdIdController = TextEditingController();
  String? get _ntdId => _ntdIdController.text;

  bool _newletterSubscription = false;
  bool _jobsletterSubscription = false;

  int? ntdLoai;
  final _nongThonThanhThiController = TextEditingController();
  String? idLoaiHinhDoanhNghiep;
  String? idNganhKinhTe;
  int? idStatus;
  int? displayOrder;
  int? ntdHinhthucdoanhnghiep;
  int? ntdChucvu;

  String? _selectedTinh;
  String? _selectedHuyen;
  String? _selectedXa;
  String? _selectedKCN;
  int? maTinh;
  String? maHuyen;
  String? maXa;
  int? maKCN;
  int? ntdQuocgia;

  // List<ChucDanhModel> _chucDanhs = []; // Removed
  ChucDanhModel? chucDanh;

  // List<HinhThucDoanhNghiep> _hinhthucDoanhNghieps = []; // Removed
  HinhThucDoanhNghiep? hinhthucDoanhNghiep;

  // List<LoaiHinh> _loaihinhs = []; // Removed
  LoaiHinh? loaihinh;

  final _idDoanhNghiepController = TextEditingController();

  int? idThoiGianHoatDong;
  List<ThoiGianHoatDong> _thoigianhoatdongs = [];
  ThoiGianHoatDong? thoigianhoatdong;

  // List<NganhNgheKT> _nganhNghes = []; // Removed
  // NganhNgheKT? nganhNghe; // Removed

  @override
  void initState() {
    super.initState();
    // _loadChucDanh(); // Removed
    // _loadHinhThucDoanhNghiep(); // Removed
    // _loadLoaiHinh(); // Removed
    // _loadNganhNghe(); // Removed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ntdBloc = locator<NTDBloc>();
    if (ntdBloc.state is NTDLoadedById) {
      final ntd = (ntdBloc.state as NTDLoadedById).ntd;
      if (ntd != null) {
        _idDoanhNghiepController.text = ntd.idDoanhNghiep?.toString() ?? '';
        _usernameController.text = ntd.username ?? '';
        _passwordController.text = ntd.password ?? '';
        _ntdMadnController.text = ntd.ntdMadn ?? '';
        _ntdTentatController.text = ntd.ntdTentat ?? '';
        _ntdTenController.text = ntd.ntdTen ?? '';
        _ntdEmailController.text = ntd.ntdEmail ?? '';
        _ntdSolaodongController.text = ntd.ntdSolaodong?.toString() ?? '';
        _ntdGioithieuController.text = ntd.ntdGioithieu ?? '';
        _ntdDiachithanhphoController.text =
            ntd.ntdDiachithanhpho?.toString() ?? '';
        maTinh = ntd.ntdDiachithanhpho != null
            ? int.tryParse(ntd.ntdDiachithanhpho!)
            : null;
        maHuyen = ntd.ntdDiachihuyen;
        maXa = ntd.ntdDiachixaphuong;
        maKCN = ntd.ntdThuockhucongnghiep;
        _mstController.text = ntd.mst ?? '';
        ntdChucvu = ntd.ntdChucvu;
        _ntdDiachihuyenController.text = ntd.ntdDiachihuyen ?? '';
        _ntdDiachixaphuongController.text = ntd.ntdDiachixaphuong ?? '';
        _ntdDiachichitietController.text = ntd.ntdDiachichitiet ?? '';
        _ntdNguoilienheController.text = ntd.ntdNguoilienhe ?? '';
        _ntdDienthoaiController.text = ntd.ntdDienthoai ?? '';
        _ntdFaxController.text = ntd.ntdFax ?? '';
        _ntdWebsiteController.text = ntd.ntdWebsite ?? '';
        _ntdNamthanhlapController.text = ntd.ntdNamthanhlap?.toString() ?? '';
        _ntdLinhvuchoatdongController.text = ntd.ntdLinhvuchoatdong ?? '';
        _nongThonThanhThiController.text = ntd.nongThonThanhThi ?? '';

        _selectedTinh = ntd.ntdTenTinh;
        _selectedHuyen = ntd.ntdTenHuyen;
        _selectedXa = ntd.ntdTenXa;

        _ntdhtNlh = ntd.ntdhtNlh ?? false;
        _ntdhtTelephone = ntd.ntdhtTelephone ?? false;
        _ntdhtWeb = ntd.ntdhtWeb ?? false;
        _ntdhtFax = ntd.ntdhtFax ?? false;
        _ntdhtEmail = ntd.ntdhtEmail ?? false;
        _ntdhtAddress = ntd.ntdhtAddress ?? false;
        _newletterSubscription = ntd.newsletterSubscription ?? false;
        _jobsletterSubscription = ntd.jobsletterSubscription ?? false;
        idThoiGianHoatDong = ntd.idThoiGianHoatDong;
        idStatus = ntd.idStatus;
        idNganhKinhTe = ntd.idNganhKinhTe;
        idLoaiHinhDoanhNghiep = ntd.idLoaiHinhDoanhNghiep;
        ntdLoai = ntd.ntdLoai;
        ntdHinhthucdoanhnghiep = ntd.ntdHinhthucdoanhnghiep;
        ntdQuocgia = ntd.idQuocGia;

        // Initialize model instances for GenericPickers
        if (ntdChucvu != null) {
          try {
            chucDanh = locator<List<ChucDanhModel>>().firstWhere(
              (item) => item.id == ntdChucvu,
              orElse: () => null as ChucDanhModel,
            );
          } catch (e) {
            debugPrint('Error finding ChucDanh: $e');
          }
        }
        if (ntdHinhthucdoanhnghiep != null) {
          try {
            hinhthucDoanhNghiep =
                locator<List<HinhThucDoanhNghiep>>().firstWhere(
              (item) => item.id == ntdHinhthucdoanhnghiep,
              orElse: () => null as HinhThucDoanhNghiep,
            );
          } catch (e) {
            debugPrint('Error finding HinhThucDoanhNghiep: $e');
          }
        }
        if (idLoaiHinhDoanhNghiep != null) {
          try {
            loaihinh = locator<List<LoaiHinh>>().firstWhere(
              (item) => item.id == idLoaiHinhDoanhNghiep,
              orElse: () => null as LoaiHinh,
            );
          } catch (e) {
            debugPrint('Error finding LoaiHinh: $e');
          }
        }
        // NganhNgheKT model instance (nganhNghe) is not set/used by its picker or _handleUpdate directly.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text('Cập nhật thông tin',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        centerTitle: true,
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
        child: SafeArea(
          child: BlocListener<NTDBloc, NTDState>(
            bloc: locator<NTDBloc>(),
            listener: (context, state) {
              if (state is NTDLoaded) {
                // Schedule navigation for the next frame to ensure proper cleanup
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                });
              }
              if (state is NTDError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
              if (state is NTDSuccess) {
                // Schedule navigation for the next frame to ensure proper cleanup
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ToastUtils.showToastSuccess(context,
                      message: state.message,
                      description: 'Cập nhật thành công');
                  context.go('/ntd_home');
                });
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withAlpha(26),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cập nhật thông tin',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Vui lòng cập nhật thông tin của bạn',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    theme.colorScheme.onSurface.withAlpha(179),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Account Information Section
                      _buildSectionHeader(theme, 'Thông tin tài khoản'),
                      const SizedBox(height: 8),
                      AccountInfoSection(
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        ntdMadnController: _ntdMadnController,
                        ntdEmailController: _ntdEmailController,
                        mstController: _mstController,
                        theme: theme,
                      ),
                      const SizedBox(height: 16),

                      // Contact Information Section
                      _buildSectionHeader(theme, 'Thông tin người liên hệ'),
                      const SizedBox(height: 16),
                      ContactInfoSection(
                        ntdNguoilienheController: _ntdNguoilienheController,
                        ntdChucvu: ntdChucvu,
                        onChucDanhChanged: (value) {
                          setState(() {
                            ntdChucvu = value?.id;
                            chucDanh = value;
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Company Information Section
                      _buildSectionHeader(theme, 'Thông tin doanh nghiệp'),
                      const SizedBox(height: 16),
                      CompanyInfoSection(
                        ntdTenController: _ntdTenController,
                        ntdTentatController: _ntdTentatController,
                        ntdLoai: ntdLoai,
                        onNtdLoaiChanged: (value) {
                          setState(() {
                            ntdLoai = value;
                          });
                        },
                        idNganhKinhTe: idNganhKinhTe,
                        onNganhKinhTeChanged: (value) {
                          setState(() {
                            idNganhKinhTe = value?.id.toString();
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Status and Activity Section
                      _buildSectionHeader(theme, 'Trạng thái và hoạt động'),
                      const SizedBox(height: 16),
                      StatusAndActivitySection(
                        idStatus: idStatus,
                        onStatusChanged: (value) {
                          setState(() {
                            idStatus = value;
                          });
                        },
                        idThoiGianHoatDong: idThoiGianHoatDong,
                        onThoiGianHoatDongChanged: (value) {
                          setState(() {
                            idThoiGianHoatDong = value;
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Company Type Section
                      _buildSectionHeader(theme, 'Loại hình doanh nghiệp'),
                      const SizedBox(height: 16),
                      CompanyTypeSection(
                        ntdHinhthucdoanhnghiep: ntdHinhthucdoanhnghiep,
                        onHinhThucDoanhNghiepChanged: (value) {
                          setState(() {
                            ntdHinhthucdoanhnghiep = value?.id;
                            hinhthucDoanhNghiep = value;
                          });
                        },
                        idLoaiHinhDoanhNghiep: idLoaiHinhDoanhNghiep,
                        onLoaiHinhChanged: (value) {
                          setState(() {
                            idLoaiHinhDoanhNghiep = value?.id;
                            loaihinh = value;
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Location Section
                      _buildSectionHeader(theme, 'Địa chỉ'),
                      const SizedBox(height: 16),
                      LocationSection(
                        initialTinh: maTinh.toString(),
                        initialHuyen: maHuyen,
                        initialXa: maXa,
                        initialKCN: maKCN.toString(),
                        addressDetailController: _ntdDiachichitietController,
                        onTinhChanged: (tinh) {
                          setState(() {
                            _selectedTinh = tinh?.tentinh;
                            maTinh = int.tryParse(tinh?.matinh ?? '');
                          });
                        },
                        onHuyenChanged: (huyen) {
                          setState(() {
                            _selectedHuyen = huyen?.tenhuyen;
                            maHuyen = huyen?.mahuyen;
                          });
                        },
                        onXaChanged: (xa) {
                          setState(() {
                            _selectedXa = xa?.tenxa;
                            maXa = xa?.maxa;
                          });
                        },
                        onKCNChanged: (kcn) {
                          setState(() {
                            _selectedKCN = kcn?.displayName;
                            maKCN = kcn?.id;
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Contact Details Section
                      _buildSectionHeader(theme, 'Thông tin liên hệ'),
                      const SizedBox(height: 16),
                      ContactDetailsSection(
                        ntdWebsiteController: _ntdWebsiteController,
                        ntdFaxController: _ntdFaxController,
                        ntdDienthoaiController: _ntdDienthoaiController,
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Display Settings Section
                      _buildSectionHeader(theme, 'Cài đặt hiển thị'),
                      const SizedBox(height: 16),
                      DisplaySettingsSection(
                        ntdhtNlh: _ntdhtNlh,
                        onNtdhtNlhChanged: (value) {
                          setState(() {
                            _ntdhtNlh = value ?? false;
                          });
                        },
                        ntdhtTelephone: _ntdhtTelephone,
                        onNtdhtTelephoneChanged: (value) {
                          setState(() {
                            _ntdhtTelephone = value ?? false;
                          });
                        },
                        ntdhtWeb: _ntdhtWeb,
                        onNtdhtWebChanged: (value) {
                          setState(() {
                            _ntdhtWeb = value ?? false;
                          });
                        },
                        ntdhtFax: _ntdhtFax,
                        onNtdhtFaxChanged: (value) {
                          setState(() {
                            _ntdhtFax = value ?? false;
                          });
                        },
                        ntdhtEmail: _ntdhtEmail,
                        onNtdhtEmailChanged: (value) {
                          setState(() {
                            _ntdhtEmail = value ?? false;
                          });
                        },
                        ntdhtAddress: _ntdhtAddress,
                        onNtdhtAddressChanged: (value) {
                          setState(() {
                            _ntdhtAddress = value ?? false;
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Notification Settings Section
                      _buildSectionHeader(theme, 'Cài đặt thông báo'),
                      const SizedBox(height: 16),
                      NotificationSettingsSection(
                        newletterSubscription: _newletterSubscription,
                        onNewletterSubscriptionChanged: (value) {
                          setState(() {
                            _newletterSubscription = value ?? false;
                          });
                        },
                        jobsletterSubscription: _jobsletterSubscription,
                        onJobsletterSubscriptionChanged: (value) {
                          setState(() {
                            _jobsletterSubscription = value ?? false;
                          });
                        },
                        theme: theme,
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (mounted && _formKey.currentState!.validate()) {
                              _handleUpdate();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cập nhật',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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

  void _handleUpdate() {
    // Don't proceed if widget is disposed
    if (!mounted) return;

    final ntdBloc = locator<NTDBloc>();
    if (ntdBloc.state is NTDLoadedById) {
      final originalNtd = (ntdBloc.state as NTDLoadedById).ntd;
      if (originalNtd != null) {
        // Capture all controller values first
        final username = _usernameController.text;
        final password = _passwordController.text;
        final ntdMadn = _ntdMadnController.text;
        final ntdTentat = _ntdTentatController.text;
        final ntdTen = _ntdTenController.text;
        final mst = _mstController.text;
        final ntdSolaodong = _ntdSolaodongController.text;
        final ntdGioithieu = _ntdGioithieuController.text;
        final ntdDiachichitiet = _ntdDiachichitietController.text;
        final ntdNguoilienhe = _ntdNguoilienheController.text;
        final ntdDienthoai = _ntdDienthoaiController.text;
        final ntdFax = _ntdFaxController.text;
        final ntdEmail = _ntdEmailController.text;
        final ntdWebsite = _ntdWebsiteController.text;
        final ntdNamthanhlap = _ntdNamthanhlapController.text;
        final ntdLinhvuchoatdong = _ntdLinhvuchoatdongController.text;
        final nongThonThanhThi = _nongThonThanhThiController.text;

        final updatedNtd = originalNtd.copyWith(
          username: username,
          password: password,
          ntdMadn: ntdMadn,
          ntdTentat: ntdTentat,
          ntdTen: ntdTen,
          mst: mst,
          ntdSolaodong: int.tryParse(ntdSolaodong),
          ntdGioithieu: ntdGioithieu,
          ntdThuockhucongnghiep: maKCN,
          ntdDiachithanhpho: maTinh.toString(),
          ntdDiachihuyen: maHuyen,
          ntdDiachixaphuong: maXa,
          ntdDiachichitiet: ntdDiachichitiet,
          ntdNguoilienhe: ntdNguoilienhe,
          ntdChucvu: chucDanh?.id,
          ntdDienthoai: ntdDienthoai,
          ntdFax: ntdFax,
          ntdEmail: ntdEmail,
          ntdWebsite: ntdWebsite,
          ntdQuocgia: ntdQuocgia?.toString(),
          ntdNamthanhlap: int.tryParse(ntdNamthanhlap),
          ntdLinhvuchoatdong: ntdLinhvuchoatdong,
          ntdhtNlh: _ntdhtNlh,
          ntdhtTelephone: _ntdhtTelephone,
          ntdhtWeb: _ntdhtWeb,
          ntdhtFax: _ntdhtFax,
          ntdhtEmail: _ntdhtEmail,
          ntdhtAddress: _ntdhtAddress,
          ntdId: _ntdIdController.text,
          newsletterSubscription: _newletterSubscription,
          jobsletterSubscription: _jobsletterSubscription,
          ntdLoai: ntdLoai,
          nongThonThanhThi: nongThonThanhThi,
          idLoaiHinhDoanhNghiep: idLoaiHinhDoanhNghiep,
          idNganhKinhTe: idNganhKinhTe,
          idThoiGianHoatDong: idThoiGianHoatDong,
          ntdHinhthucdoanhnghiep: ntdHinhthucdoanhnghiep,
          ntdTenTinh: _selectedTinh,
          ntdTenHuyen: _selectedHuyen,
          ntdTenXa: _selectedXa,
        );

        // Only add the event if the widget is still mounted
        if (mounted) {
          ntdBloc.add(NTDUpdate(updatedNtd));
        }
      }
    }
  }

  @override
  void dispose() {
    _idDoanhNghiepController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _mstController.dispose();
    _ntdMadnController.dispose();
    _ntdTentatController.dispose();
    _ntdTenController.dispose();
    _ntdEmailController.dispose();
    _ntdSolaodongController.dispose();
    _ntdGioithieuController.dispose();
    _ntdDiachithanhphoController.dispose();
    _ntdDiachihuyenController.dispose();
    _ntdDiachixaphuongController.dispose();
    _ntdDiachichitietController.dispose();
    _ntdNguoilienheController.dispose();
    _ntdDienthoaiController.dispose();
    _ntdFaxController.dispose();
    _ntdWebsiteController.dispose();
    _ntdNamthanhlapController.dispose();
    _ntdLinhvuchoatdongController.dispose();
    _nongThonThanhThiController.dispose();
    _ntdThuockhucongnghiepController.dispose();
    _ntdIdController.dispose();

    super.dispose();
  }
}
