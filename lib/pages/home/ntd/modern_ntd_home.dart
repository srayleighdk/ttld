import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_shadows.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';
import 'package:ttld/core/design_system/widgets/app_card.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/widgets/common/letter_avatar.dart';

class ModernNTDHomePage extends StatefulWidget {
  static const routePath = '/ntd_home';
  const ModernNTDHomePage({super.key});

  @override
  State<ModernNTDHomePage> createState() => _ModernNTDHomePageState();
}

class _ModernNTDHomePageState extends State<ModernNTDHomePage> {
  Ntd? ntd;
  String? userId;
  late NTVBloc _hoSoUngVienBloc;
  late NTDBloc _ntdBloc;
  bool _isInitialLoading = true;
  String _avatarBaseUrl = '';

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
    _loadAvatarBaseUrl();
  }

  void _initializeBlocs() {
    _hoSoUngVienBloc = locator<NTVBloc>();
    _ntdBloc = locator<NTDBloc>();

    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      userId = authState.userId;
      if (!_ntdBloc.isClosed) {
        _ntdBloc.add(NTDFetchById(int.parse(userId!)));
      }
    }
    if (!_hoSoUngVienBloc.isClosed) {
      _hoSoUngVienBloc.add(LoadTblHoSoUngViens());
    }
  }

  Future<void> _loadAvatarBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRegionName = prefs.getString('selected_region');
    final savedRegion = regionFromString(savedRegionName);

    if (savedRegion != null) {
      setState(() {
        _avatarBaseUrl = getEnv(savedRegion.avatarUrlKey);
      });
    } else {
      setState(() {
        _avatarBaseUrl = getEnv('URL_AVATAR_BD');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: BlocBuilder<NTDBloc, NTDState>(
          bloc: _ntdBloc,
          builder: (context, ntdState) {
            return BlocBuilder<NTVBloc, NTVState>(
              bloc: _hoSoUngVienBloc,
              builder: (context, ntvState) {
                if (_isInitialLoading &&
                    (ntdState is NTDLoading || ntvState is NTVLoading)) {
                  return Center(child: CircularProgressIndicator());
                }

                if (ntdState is NTDLoadedById) {
                  _isInitialLoading = false;
                  ntd = ntdState.ntd;
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCompanyCard(ntdState),
                      SizedBox(height: AppSpacing.lg),
                      _buildQuickActions(),
                      SizedBox(height: AppSpacing.lg),
                      _buildServicesSection(),
                      SizedBox(height: AppSpacing.lg),
                      _buildStatisticsCard(ntvState),
                      SizedBox(height: AppSpacing.massive),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCompanyCard(NTDState state) {
    if (state is NTDLoadedById) {
      final ntd = state.ntd;
      return AppCard.elevated(
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                boxShadow: AppShadows.sm,
              ),
              child: NetworkLetterAvatar(
                name: ntd.ntdTen ?? 'Nhà Tuyển Dụng',
                imageUrl: (_avatarBaseUrl.isNotEmpty &&
                        ntd.imagePath != null &&
                        ntd.imagePath!.isNotEmpty)
                    ? '$_avatarBaseUrl${ntd.imagePath}'
                    : null,
                size: 66,
              ),
            ),
            SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chào mừng trở lại,',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    ntd.ntdTen ?? 'Unknown Company',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.successContainer,
                borderRadius: AppRadius.radiusSM,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'Active',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (state is NTDError) {
      return AppCard.elevated(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            SizedBox(height: AppSpacing.md),
            Text(
              'Có lỗi xảy ra',
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.error,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              state.message,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.business_center_outlined,
            label: 'Sàn GDVL',
            gradient: [AppColors.primary, AppColors.primaryDark],
            onTap: () => context.push('/ntd_home/sgdvl'),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildActionCard(
            icon: Icons.analytics_outlined,
            label: 'Tổng quan',
            gradient: [AppColors.success, AppColors.successDark],
            onTap: () => context.push('/ntd_home/tong_quan'),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildActionCard(
            icon: Icons.handshake_outlined,
            label: 'Chắp Nối',
            gradient: [AppColors.secondary, AppColors.secondaryDark],
            onTap: () => context.push('/ntd_home/ho-so-chap-noi', extra: {
              'tabIndex': 0,
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return AppCard.elevated(
      onTap: onTap,
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: AppRadius.radiusMD,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dịch vụ tuyển dụng',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.1,
          children: [
            _buildServiceCard(
              icon: Icons.add_circle_outline,
              title: 'Thêm tuyển dụng',
              subtitle: 'Đăng tin mới',
              color: AppColors.success,
              onTap: () => context.push('/ntd_home/create_tuyen_dung', extra: {
                'ntd': ntd,
                'isEdit': false,
              }),
            ),
            _buildServiceCard(
              icon: Icons.edit_outlined,
              title: 'Cập nhật TT',
              subtitle: 'Phiếu tuyển dụng',
              color: AppColors.primary,
              onTap: () => context.push('/update_ntd'),
            ),
            _buildServiceCard(
              icon: Icons.work_outline,
              title: 'Quản lý TD',
              subtitle: 'Tin tuyển dụng',
              color: AppColors.info,
              onTap: () => context.push('/ntd_home/quan-ly-tuyen-dung', extra: userId),
            ),
            _buildServiceCard(
              icon: Icons.people_outline,
              title: 'Quản lý NV',
              subtitle: 'Nhân viên',
              color: AppColors.warning,
              onTap: () => context.push('/feature-locked', extra: {
                'featureName': 'Quản lý nhân viên',
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AppCard.elevated(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: AppRadius.radiusMD,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard(NTVState state) {
    if (state is NTVLoaded) {
      final totalApplicants = state.tblHoSoUngViens.length;
      return AppCard.elevated(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: AppRadius.radiusSM,
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Text(
                  'Thống kê ứng viên',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Tổng ứng viên',
                    totalApplicants.toString(),
                    AppColors.primary,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.border,
                ),
                Expanded(
                  child: _buildStatItem(
                    'Đang hoạt động',
                    totalApplicants.toString(),
                    AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
