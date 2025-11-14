import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/widgets/common/letter_avatar.dart';

class ProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final List<Widget>? actions;

  const ProfileAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.actions,
  });

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  String _avatarBaseUrl = '';

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              // Profile Avatar and Info
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  bloc: locator<AuthBloc>(),
                  builder: (context, authState) {
                    if (authState is! AuthAuthenticated) {
                      return Text(
                        widget.title,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }

                    if (authState.userType == 'ntv') {
                      return _buildNTVProfile(authState);
                    } else if (authState.userType == 'ntd') {
                      return _buildNTDProfile(authState);
                    }

                    return Text(
                      widget.title,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
              // Actions
              if (widget.actions != null) ...widget.actions!,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNTVProfile(AuthAuthenticated authState) {
    return BlocBuilder<NTVBloc, NTVState>(
      bloc: locator<NTVBloc>(),
      builder: (context, state) {
        TblHoSoUngVienModel? profile;
        if (state is NTVLoadedById) {
          profile = state.tblHoSoUngVien;
        }

        return GestureDetector(
          onTap: widget.onProfileTap,
          child: Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: NetworkLetterAvatar(
                  name: profile?.uvHoten ?? authState.userName,
                  imageUrl: (_avatarBaseUrl.isNotEmpty &&
                          profile?.avatarUrl != null &&
                          profile!.avatarUrl!.isNotEmpty)
                      ? '$_avatarBaseUrl${profile.avatarUrl}'
                      : null,
                  size: 36,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              // Name and greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Xin chào 👋',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      profile?.uvHoten ?? authState.userName,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNTDProfile(AuthAuthenticated authState) {
    return BlocBuilder<NTDBloc, NTDState>(
      bloc: locator<NTDBloc>(),
      builder: (context, state) {
        Ntd? company;
        if (state is NTDLoadedById) {
          company = state.ntd;
        }

        return GestureDetector(
          onTap: widget.onProfileTap,
          child: Row(
            children: [
              // Company Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: NetworkLetterAvatar(
                  name: company?.ntdTen ?? authState.userName,
                  imageUrl: (_avatarBaseUrl.isNotEmpty &&
                          company?.imagePath != null &&
                          company!.imagePath!.isNotEmpty)
                      ? '$_avatarBaseUrl${company.imagePath}'
                      : null,
                  size: 36,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              // Company name and greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Chào mừng 👋',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      company?.ntdTen ?? authState.userName,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
