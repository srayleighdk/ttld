import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/blocs/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';
import 'package:ttld/core/design_system/widgets/job_card.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/pages/home/ntd/ntd_tuyendung_info_page.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/widgets/common/letter_avatar.dart';

class UltraModernNTVHome extends StatefulWidget {
  final VoidCallback? onProfileTap;

  const UltraModernNTVHome({super.key, this.onProfileTap});

  @override
  State<UltraModernNTVHome> createState() => _UltraModernNTVHomeState();
}

class _UltraModernNTVHomeState extends State<UltraModernNTVHome> {
  TblHoSoUngVienModel? tblHoSoUngVien;
  late final TuyenDungBloc _tuyenDungBloc;
  late final KinhNghiemLamViecBloc _kinhNghiemBloc;
  Map<String, String> _kinhNghiemMap = {};
  bool _isInitialLoading = true;
  String _avatarBaseUrl = '';

  String _formatDate(DateTime? date) {
    if (date == null) return 'Chưa có';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _getKinhNghiemName(String? id) {
    if (id == null) return 'Chưa có';
    return _kinhNghiemMap[id] ?? 'Chưa có';
  }

  @override
  void initState() {
    super.initState();
    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userType == 'ntv') {
      locator<NTVBloc>().add(LoadTblHoSoUngVien(int.parse(authState.userId)));
    }
    _tuyenDungBloc = TuyenDungBloc(locator<TuyenDungRepository>());
    _tuyenDungBloc.add(FetchTuyenDungList(null));
    _kinhNghiemBloc = KinhNghiemLamViecBloc(locator<KinhNghiemLamViecRepository>());
    _kinhNghiemBloc.add(FetchKinhNghiemLamViecList());
    _loadAvatarBaseUrl();
  }

  Future<void> _loadAvatarBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRegionName = prefs.getString('selected_region');
    final savedRegion = regionFromString(savedRegionName);
    if (savedRegion != null) {
      setState(() => _avatarBaseUrl = getEnv(savedRegion.avatarUrlKey));
    } else {
      setState(() => _avatarBaseUrl = getEnv('URL_AVATAR_BD'));
    }
  }

  @override
  void dispose() {
    _tuyenDungBloc.close();
    _kinhNghiemBloc.close();
    super.dispose();
  }

  void _checkProfileBeforeNavigation(BuildContext context, String route) {
    if (tblHoSoUngVien == null ||
        tblHoSoUngVien!.uvnvNganhngheId == null ||
        tblHoSoUngVien!.uvnvNganhngheId == 0) {
      _showProfileIncompleteDialog(context);
    } else {
      context.push(route);
    }
  }

  void _showProfileIncompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.dialog),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.warning, AppColors.warningDark]),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.warning_rounded, size: 40, color: Colors.white),
              ),
              SizedBox(height: AppSpacing.xxl),
              Text(
                'Thông tin chưa đầy đủ',
                style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'Bạn cần cập nhật thông tin ngành nghề mong muốn trước khi có thể tìm việc làm.',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.xxxl),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
                      ),
                      child: Text('Để sau'),
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.push('/ntv_home/update_ntv');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
                      ),
                      child: Text('Cập nhật ngay', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<NTVBloc, NTVState>(
              bloc: locator<NTVBloc>(),
              listener: (context, state) {
                if (state is NTVLoadedById) {
                  setState(() {
                    tblHoSoUngVien = state.tblHoSoUngVien;
                    _isInitialLoading = false;
                  });
                }
              },
            ),
            BlocListener<KinhNghiemLamViecBloc, KinhNghiemLamViecState>(
              bloc: _kinhNghiemBloc,
              listener: (context, state) {
                if (state is KinhNghiemLamViecLoaded) {
                  setState(() {
                    _kinhNghiemMap = {
                      for (var kn in state.kinhNghiemList) kn.id.toString(): kn.displayName
                    };
                  });
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuickActions(),
                SizedBox(height: AppSpacing.lg),
                _buildFeaturedSection(),
                SizedBox(height: AppSpacing.lg),
                _buildServicesGrid(),
                SizedBox(height: AppSpacing.lg),
                _buildJobOpportunities(),
                SizedBox(height: AppSpacing.massive),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'Tìm Việc',
            Icons.search_rounded,
            [AppColors.primary, AppColors.primaryDark],
            () => _checkProfileBeforeNavigation(context, '/ntv_home/tim-viec'),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildActionButton(
            'Sàn GDVL',
            Icons.business_center_rounded,
            [AppColors.secondary, AppColors.secondaryDark],
            () => context.push('/ntv_home/sgdvl'),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, List<Color> colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: AppRadius.card,
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.card,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.success, AppColors.successDark]),
              borderRadius: AppRadius.radiusMD,
            ),
            child: Icon(Icons.handshake_rounded, color: Colors.white),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chắp Nối Việc Làm', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                Text('Kết nối với nhà tuyển dụng', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push('/ntv_home/ho-so-chap-noi'),
            icon: Icon(Icons.arrow_forward_ios_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.neutral100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobOpportunities() {
    return BlocBuilder<TuyenDungBloc, TuyenDungState>(
      bloc: _tuyenDungBloc,
      builder: (context, state) {
        if (state is TuyenDungLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is TuyenDungError) {
          return Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              borderRadius: AppRadius.card,
            ),
            child: Column(
              children: [
                Text(
                  'Không thể tải danh sách việc làm',
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.error),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Chi tiết: ${state.message}',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.error),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (state is TuyenDungLoaded && state.tuyenDungList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cơ hội việc làm',
                        style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${state.tuyenDungList.length} vị trí đang tuyển',
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => _checkProfileBeforeNavigation(context, '/ntv_home/tim-viec'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Xem tất cả'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              // Job cards
              ...state.tuyenDungList.take(3).map((tuyenDung) {
                return JobCard(
                  jobTitle: tuyenDung.tdTieude ?? 'Chưa có tiêu đề',
                  companyName: tuyenDung.tdTieude,
                  location: tuyenDung.noiLamviec,
                  salary: tuyenDung.mucLuong,
                  quantity: tuyenDung.tdSoluong,
                  experience: _getKinhNghiemName(tuyenDung.idKinhnghiem),
                  postedDate: tuyenDung.modifiredDate != null
                      ? '📅 ${_formatDate(tuyenDung.modifiredDate)}'
                      : null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NTDInfoPage(
                          ntdData: {
                            'tuyendungId': tuyenDung.idTuyenDung,
                            'tuyendung': tuyenDung.tdTieude ?? '',
                            'soLuong': tuyenDung.tdSoluong.toString(),
                            'gioiTinh': tuyenDung.tdYeuCauGioiTinh,
                            'trinhDo': tuyenDung.tdYeuCauHocVan ?? '',
                            'nganhNghe': tuyenDung.tdNganhnghe ?? '',
                            'moTaCongViec': tuyenDung.tdMotacongviec ?? '',
                            'ngayNhanHoSo': tuyenDung.ngayNhanHoSo ?? '',
                            'tenNTD': tuyenDung.tdTieude ?? '',
                            'address': tuyenDung.noiLamviec ?? '',
                            'idDoanhNghiep': tuyenDung.idDoanhNghiep.toString(),
                            'ngayDang': tuyenDung.createdDate != null
                                ? _formatDate(tuyenDung.createdDate!)
                                : '',
                            'mucLuong': tuyenDung.mucLuong ?? '',
                            'idKinhnghiem': tuyenDung.idKinhnghiem ?? '',
                            'tdNoinophoso': tuyenDung.tdNoinophoso ?? '',
                            'tdHosobaogom': tuyenDung.tdHosobaogom ?? '',
                            'tdGhichu': tuyenDung.tdGhichu ?? '',
                          },
                        ),
                      ),
                    );
                  },
                  onApply: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ứng tuyển: ${tuyenDung.tdTieude}'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {'icon': Icons.edit_document, 'title': 'Cập nhật hồ sơ', 'color': AppColors.primary, 'route': '/ntv_home/update_ntv'},
      {'icon': Icons.app_registration_rounded, 'title': 'Đăng ký tìm việc làm', 'color': AppColors.error, 'route': '/ntv_home/dang-ky-tim-viec-lam-list'},
      {'icon': Icons.school_rounded, 'title': 'Đăng ký học nghề', 'color': AppColors.success, 'route': '/ntv_home/dang-ky-hoc-nghe'},
      {'icon': Icons.school_outlined, 'title': 'Đăng ký học nghề BHTN', 'color': AppColors.info, 'route': null},
      {'icon': Icons.flight_takeoff_rounded, 'title': 'Đăng ký XKLĐ', 'color': AppColors.warning, 'route': '/ntv_home/dang-ky-xuat-khao-lao-dong'},
      {'icon': Icons.handshake_rounded, 'title': 'Kết nối việc làm', 'color': Color(0xFF00BCD4), 'route': '/ntv_home/ho-so-chap-noi'},
      {'icon': Icons.description_rounded, 'title': 'Hợp đồng lao động', 'color': Color(0xFF3F51B5), 'route': null},
      {'icon': Icons.file_present_rounded, 'title': 'Xuất file CV', 'color': Color(0xFF9C27B0), 'route': null},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dịch vụ việc làm',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 0.75,
          ),
          itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () {
            if (service['route'] != null) {
              context.push(service['route'] as String, extra: tblHoSoUngVien);
            } else {
              context.push('/feature-locked', extra: {'featureName': service['title']});
            }
          },
          child: Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.radiusMD,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (service['color'] as Color).withOpacity(0.1),
                    borderRadius: AppRadius.radiusSM,
                  ),
                  child: Icon(service['icon'] as IconData, color: service['color'] as Color, size: 24),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  service['title'] as String,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    ),
      ],
    );
  }
}
