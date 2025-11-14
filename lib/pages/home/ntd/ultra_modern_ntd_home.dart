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
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/widgets/common/letter_avatar.dart';

class UltraModernNTDHome extends StatefulWidget {
  const UltraModernNTDHome({super.key});

  @override
  State<UltraModernNTDHome> createState() => _UltraModernNTDHomeState();
}

class _UltraModernNTDHomeState extends State<UltraModernNTDHome> {
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
      setState(() => _avatarBaseUrl = getEnv(savedRegion.avatarUrlKey));
    } else {
      setState(() => _avatarBaseUrl = getEnv('URL_AVATAR_BD'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: BlocBuilder<NTDBloc, NTDState>(
          bloc: _ntdBloc,
          builder: (context, ntdState) {
            return BlocBuilder<NTVBloc, NTVState>(
              bloc: _hoSoUngVienBloc,
              builder: (context, ntvState) {
                if (_isInitialLoading && (ntdState is NTDLoading || ntvState is NTVLoading)) {
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
                      _buildQuickActions(),
                      SizedBox(height: AppSpacing.lg),
                      _buildStatsCard(ntvState),
                      SizedBox(height: AppSpacing.lg),
                      _buildServicesGrid(),
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

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'Đăng tin TD',
            Icons.add_circle_rounded,
            [AppColors.success, AppColors.successDark],
            () => context.push('/ntd_home/create_tuyen_dung', extra: {'ntd': ntd, 'isEdit': false}),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildActionButton(
            'Quản lý TD',
            Icons.work_rounded,
            [AppColors.primary, AppColors.primaryDark],
            () => context.push('/ntd_home/quan-ly-tuyen-dung', extra: userId),
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

  Widget _buildStatsCard(NTVState state) {
    final totalApplicants = state is NTVLoaded ? state.tblHoSoUngViens.length : 0;
    
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.primaryGradient),
                  borderRadius: AppRadius.radiusSM,
                ),
                child: Icon(Icons.analytics_rounded, color: Colors.white, size: 20),
              ),
              SizedBox(width: AppSpacing.md),
              Text(
                'Thống kê ứng viên',
                style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Tổng ứng viên', totalApplicants.toString(), AppColors.primary),
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              Expanded(
                child: _buildStatItem('Đang hoạt động', totalApplicants.toString(), AppColors.success),
              ),
            ],
          ),
        ],
      ),
    );
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
          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {'icon': Icons.edit_document, 'title': 'Cập nhật TT', 'color': AppColors.primary, 'route': '/update_ntd'},
      {'icon': Icons.business_center_rounded, 'title': 'Sàn GDVL', 'color': AppColors.secondary, 'route': '/ntd_home/sgdvl'},
      {'icon': Icons.analytics_rounded, 'title': 'Tổng quan', 'color': AppColors.info, 'route': '/ntd_home/tong_quan'},
      {'icon': Icons.handshake_rounded, 'title': 'Chắp Nối', 'color': AppColors.success, 'route': '/ntd_home/ho-so-chap-noi'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.2,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () {
            if (service['route'] == '/ntd_home/ho-so-chap-noi') {
              context.push(service['route'] as String, extra: {'tabIndex': 0});
            } else {
              context.push(service['route'] as String);
            }
          },
          child: Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.card,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: (service['color'] as Color).withOpacity(0.1),
                    borderRadius: AppRadius.radiusMD,
                  ),
                  child: Icon(service['icon'] as IconData, color: service['color'] as Color, size: 28),
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  service['title'] as String,
                  style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
