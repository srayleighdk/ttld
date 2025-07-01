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
import 'package:ttld/widgets/common/custom_app_bar.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

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
    final colorStyles =
        ThemeProvider.themeOf(context).data.extension<ColorStyles>();

    return Scaffold(
      backgroundColor: colorStyles?.background ?? theme.colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Cập nhật thông tin',
        automaticallyImplyLeading: true,
        backgroundColor:
            colorStyles?.appBarBackground ?? theme.colorScheme.primary,
        foregroundColor:
            colorStyles?.appBarPrimaryContent ?? theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              (colorStyles?.primaryAccent ?? theme.colorScheme.primary)
                  .withOpacity(0.03),
              colorStyles?.background ?? theme.colorScheme.surface,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: BlocListener<NTDBloc, NTDState>(
            bloc: locator<NTDBloc>(),
            listener: (context, state) {
              if (state is NTDLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) Navigator.pop(context);
                });
              }
              if (state is NTDError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: theme.colorScheme.error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }
              if (state is NTDSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    ToastUtils.showToastSuccess(
                      context,
                      message: state.message,
                      description: 'Cập nhật thành công',
                    );
                    context.go('/ntd_home');
                  }
                });
              }
            },
            child: CustomScrollView(
              slivers: [
                // Header Section
                SliverToBoxAdapter(
                  child: _buildHeaderSection(theme, colorStyles),
                ),

                // Form Content
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Account Information Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Thông tin tài khoản',
                            icon: Icons.account_circle_outlined,
                            child: AccountInfoSection(
                              usernameController: _usernameController,
                              passwordController: _passwordController,
                              ntdMadnController: _ntdMadnController,
                              ntdEmailController: _ntdEmailController,
                              mstController: _mstController,
                              theme: theme,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Contact Information Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Thông tin người liên hệ',
                            icon: Icons.person_outline,
                            child: ContactInfoSection(
                              ntdNguoilienheController:
                                  _ntdNguoilienheController,
                              ntdChucvu: ntdChucvu,
                              onChucDanhChanged: (value) {
                                setState(() {
                                  ntdChucvu = value?.id;
                                  chucDanh = value;
                                });
                              },
                              theme: theme,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Company Information Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Thông tin doanh nghiệp',
                            icon: Icons.business_outlined,
                            child: CompanyInfoSection(
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
                          ),

                          const SizedBox(height: 24),

                          // Status and Activity Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Trạng thái và hoạt động',
                            icon: Icons.timeline_outlined,
                            child: StatusAndActivitySection(
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
                          ),

                          const SizedBox(height: 24),

                          // Company Type Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Loại hình doanh nghiệp',
                            icon: Icons.category_outlined,
                            child: CompanyTypeSection(
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
                          ),

                          const SizedBox(height: 24),

                          // Location Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Địa chỉ',
                            icon: Icons.location_on_outlined,
                            child: LocationSection(
                              initialTinh: maTinh.toString(),
                              initialHuyen: maHuyen,
                              initialXa: maXa,
                              initialKCN: maKCN.toString(),
                              addressDetailController:
                                  _ntdDiachichitietController,
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
                          ),

                          const SizedBox(height: 24),

                          // Contact Details Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Thông tin liên hệ',
                            icon: Icons.contact_phone_outlined,
                            child: ContactDetailsSection(
                              ntdWebsiteController: _ntdWebsiteController,
                              ntdFaxController: _ntdFaxController,
                              ntdDienthoaiController: _ntdDienthoaiController,
                              theme: theme,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Display Settings Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Cài đặt hiển thị',
                            icon: Icons.visibility_outlined,
                            child: DisplaySettingsSection(
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
                          ),

                          const SizedBox(height: 24),

                          // Notification Settings Section
                          _buildFormSection(
                            theme: theme,
                            colorStyles: colorStyles,
                            title: 'Cài đặt thông báo',
                            icon: Icons.notifications_outlined,
                            child: NotificationSettingsSection(
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
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),

                // Submit Button Section
                SliverToBoxAdapter(
                  child: _buildSubmitSection(theme, colorStyles),
                ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section with app branding and description
  Widget _buildHeaderSection(ThemeData theme, ColorStyles? colorStyles) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorStyles?.surfaceBackground ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (colorStyles?.content ?? theme.colorScheme.onSurface)
                .withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      (colorStyles?.primaryAccent ?? theme.colorScheme.primary)
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  color:
                      colorStyles?.primaryAccent ?? theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cập nhật thông tin',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            colorStyles?.content ?? theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Vui lòng cập nhật thông tin doanh nghiệp của bạn',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: (colorStyles?.content ??
                                theme.colorScheme.onSurface)
                            .withOpacity(0.7),
                      ),
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

  /// Builds a form section with consistent styling
  Widget _buildFormSection({
    required ThemeData theme,
    required ColorStyles? colorStyles,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colorStyles?.surfaceBackground ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (colorStyles?.content ?? theme.colorScheme.onSurface)
                .withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: (colorStyles?.primaryAccent ?? theme.colorScheme.primary)
                  .withOpacity(0.05),
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
                    color:
                        colorStyles?.primaryAccent ?? theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: colorStyles?.appBarPrimaryContent ??
                        theme.colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                          colorStyles?.content ?? theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Section Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Builds the submit button section
  Widget _buildSubmitSection(ThemeData theme, ColorStyles? colorStyles) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (mounted && _formKey.currentState!.validate()) {
                  _handleUpdate();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorStyles?.buttonBackground ?? theme.colorScheme.primary,
                foregroundColor:
                    colorStyles?.buttonContent ?? theme.colorScheme.onPrimary,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ).copyWith(
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return 0;
                    return 2;
                  },
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save_outlined, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Cập nhật thông tin',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorStyles?.buttonContent ??
                          theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Thông tin sẽ được xem xét và cập nhật trong hệ thống',
            style: theme.textTheme.bodySmall?.copyWith(
              color: (colorStyles?.content ?? theme.colorScheme.onSurface)
                  .withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
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
