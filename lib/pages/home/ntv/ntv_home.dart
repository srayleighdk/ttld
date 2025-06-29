import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/pages/home/ntd/ntd_tuyendung_info_page.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/blocs/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:ttld/core/enums/region.dart'; // Import Region enum

class NTVHomePage extends StatefulWidget {
  final VoidCallback? onProfileTap; // Add callback parameter

  const NTVHomePage({
    super.key,
    this.onProfileTap, // Make it optional
  });

  static const String routePath = '/ntv_home';

  @override
  State<NTVHomePage> createState() => _NTVHomePageState();
}

class _NTVHomePageState extends State<NTVHomePage> {
  TblHoSoUngVienModel? tblHoSoUngVien;
  late final TuyenDungBloc _tuyenDungBloc;
  late final KinhNghiemLamViecBloc _kinhNghiemBloc;
  Map<String, String> _kinhNghiemMap = {};
  bool _isInitialLoading = true;
  String _avatarBaseUrl = ''; // Variable to store the avatar base URL

  String _formatDate(DateTime? date) {
    if (date == null) return 'Chưa có';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  void initState() {
    super.initState();
    final authState = locator<AuthBloc>()
        .state; // Keep locator for AuthBloc as per HomePage pattern
    if (authState is AuthAuthenticated && authState.userType == 'ntv') {
      // Use getIt locator for NTVBloc to maintain consistency with dependency injection
      locator<NTVBloc>().add(LoadTblHoSoUngVien(int.parse(authState.userId)));
    }
    _tuyenDungBloc = TuyenDungBloc(
        locator<TuyenDungRepository>()); // Keep local TuyenDungBloc
    _tuyenDungBloc.add(FetchTuyenDungList(null));

    _kinhNghiemBloc = KinhNghiemLamViecBloc(locator<
        KinhNghiemLamViecRepository>()); // Keep local KinhNghiemLamViecBloc
    _kinhNghiemBloc.add(FetchKinhNghiemLamViecList());

    _loadAvatarBaseUrl(); // Load avatar base URL
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
      // Fallback or error handling if region is not saved
      debugPrint('Warning: Region not found in SharedPreferences.');
      // Optionally set a default or show an error
      setState(() {
        _avatarBaseUrl = getEnv('URL_AVATAR_BD'); // Example fallback
      });
    }
  }

  @override
  void dispose() {
    _tuyenDungBloc.close();
    _kinhNghiemBloc.close();
    super.dispose();
  }

  String _getKinhNghiemName(String? id) {
    if (id == null) return 'Chưa có';
    return _kinhNghiemMap[id] ?? 'Chưa có';
  }

  // Modern action buttons section with cards and gradients
  Widget _buildActionButtonsSection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButtonItem(
            context,
            FontAwesomeIcons.buildingUser,
            'Sàn GDVL',
            '/ntv_home/sgdvl',
            [Color(0xFF4A6FFF), Color(0xFF2E5CFF)], // Blue gradient
          ),
          _buildActionButtonItem(
            context,
            FontAwesomeIcons.magnifyingGlass,
            'Tìm Việc',
            '/ntv_home/tim-viec',
            [Color(0xFFFF6B6B), Color(0xFFFF4B4B)], // Red gradient
          ),
          _buildActionButtonItem(
            context,
            FontAwesomeIcons.handshake,
            'Chắp Nối',
            '/ntv_home/ho-so-chap-noi',
            [Color(0xFF4CAF50), Color(0xFF2E7D32)], // Green gradient
          ),
        ],
      ),
    );
  }

  // Modern action button item with gradient background and elevated design
  Widget _buildActionButtonItem(
    BuildContext context,
    IconData icon,
    String label,
    String? route,
    List<Color> gradientColors,
  ) {
    final theme = Theme.of(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          onTap: () {
            if (route != null) context.push(route);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<NTVBloc, NTVState>(
              // Use getIt locator for NTVBloc to maintain consistency with dependency injection
              bloc: locator<NTVBloc>(),
              listener: (context, state) {
                if (state is NTVLoadedById) {
                  setState(() {
                    tblHoSoUngVien = state.tblHoSoUngVien;
                    _isInitialLoading = false;
                  });
                } else if (state is NTVError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${state.message}")),
                  );
                }
              },
            ),
            BlocListener<KinhNghiemLamViecBloc, KinhNghiemLamViecState>(
              bloc: _kinhNghiemBloc,
              listener: (context, state) {
                if (state is KinhNghiemLamViecLoaded) {
                  setState(() {
                    _kinhNghiemMap = {
                      for (var kn in state.kinhNghiemList)
                        kn.id.toString(): kn.displayName
                    };
                  });
                }
              },
            ),
          ],
          child: BlocBuilder<TuyenDungBloc, TuyenDungState>(
            bloc: _tuyenDungBloc,
            builder: (context, tuyenDungState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfoSection(context),
                    const SizedBox(height: 12.0),
                    _buildActionButtonsSection(context),
                    const SizedBox(height: 12.0),
                    _buildQuickAccessSection(context),
                    const SizedBox(height: 12.0),
                    _buildStatisticsSection(context, tuyenDungState),
                    const SizedBox(
                        height: 100), // Add bottom padding for navbar
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Modern user info section with glass effect and enhanced design
  Widget _buildUserInfoSection(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: locator<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withAlpha(15),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Call the callback to switch to the Profile tab
                  widget.onProfileTap?.call();
                },
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.05),
                        theme.colorScheme.surface,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Avatar with enhanced design
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.primary.withOpacity(0.7),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: _avatarBaseUrl.isNotEmpty &&
                                    tblHoSoUngVien?.avatarUrl != null &&
                                    tblHoSoUngVien!.avatarUrl!.isNotEmpty
                                ? ClipOval(
                                    child: Image.network(
                                      '$_avatarBaseUrl${tblHoSoUngVien?.avatarUrl}',
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        debugPrint(
                                            'Error loading avatar: $error');
                                        return _buildAvatarFallback(
                                            user, theme);
                                      },
                                    ),
                                  )
                                : _buildAvatarFallback(user, theme),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User info with enhanced typography
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.userName,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Profile button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            FontAwesomeIcons.angleRight,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'User not logged in',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  // Helper method for avatar fallback
  Widget _buildAvatarFallback(AuthAuthenticated user, ThemeData theme) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.surface,
      ),
      child: Center(
        child: Text(
          user.userName[0].toUpperCase(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Modern quick access section with card-based design and improved visuals
  Widget _buildQuickAccessSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Modern section header with gradient accent
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 28,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Dịch vụ việc làm',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),

        // Modern grid of quick access items
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.05),
              width: 1,
            ),
          ),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85, // Adjusted for better proportions
            children: [
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.solidPenToSquare,
                'Cập nhật TT\nPhiếu TT tìm việc',
                '/ntv_home/update_ntv',
                [Color(0xFF4A6FFF), Color(0xFF2E5CFF)], // Blue gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.calendarCheck,
                'Đăng ký tư vấn việc làm',
                '/ntv_home/dang-ky-tu-van-viec-lam',
                [Color(0xFFFF6B6B), Color(0xFFFF4B4B)], // Red gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.graduationCap,
                'Đăng ký tư vấn học nghề',
                '/ntv_home/dang-ky-hoc-nghe',
                [Color(0xFF4CAF50), Color(0xFF2E7D32)], // Green gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.plane,
                'Đăng ký xuất khẩu lao động',
                '/ntv_home/dang-ky-xuat-khao-lao-dong',
                [Color(0xFFFF9800), Color(0xFFF57C00)], // Orange gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.buildingUser,
                'Đăng ký tham gia PGDVL',
                '/ntv_home/dang-ky-tham-gia-pgdvl',
                [Color(0xFF9C27B0), Color(0xFF7B1FA2)], // Purple gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.clipboardCheck,
                'Kết quả kết nối VL',
                '/ntv_home/ket-quoc-ket-noi-vl',
                [Color(0xFF00BCD4), Color(0xFF0097A7)], // Cyan gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.fileContract,
                'Thông tin hợp đồng LD',
                '/ntv_home/thong-tin-hop-dong-ld',
                [Color(0xFF3F51B5), Color(0xFF303F9F)], // Indigo gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.chartLine,
                'Thống kê & báo cáo',
                '/ntv_home/thong-ke-bao-cao',
                [Color(0xFF607D8B), Color(0xFF455A64)], // Blue-grey gradient
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Modern quick access item with gradient background and improved visuals
  Widget _buildQuickAccessItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
    List<Color> gradientColors,
  ) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          try {
            if (route == '/ntv_home/update_ntv') {
              context.push(route, extra: tblHoSoUngVien);
            } else {
              context.push(route);
            }
          } catch (e) {
            debugPrint('Navigation error: $e');
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(10),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with gradient background
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Label with improved typography
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modern statistics section with enhanced data table design
  Widget _buildStatisticsSection(BuildContext context, TuyenDungState state) {
    final theme = Theme.of(context);

    if (state is TuyenDungError) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.error.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.triangleExclamation,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Có lỗi xảy ra',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (state is TuyenDungLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modern section header with statistics summary
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withOpacity(0.05),
                  theme.colorScheme.surface,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withAlpha(15),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Icon with gradient background
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    FontAwesomeIcons.briefcase,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cơ hội việc làm',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state.tuyenDungList.length} vị trí tuyển dụng',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // View all button
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Xem tất cả',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        FontAwesomeIcons.angleRight,
                        size: 12,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Modern data table with enhanced styling
          Container(
            height: 400, // Fixed height to make it scrollable
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withAlpha(15),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 20,
                minWidth: 500,
                headingRowHeight: 56,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(
                  theme.colorScheme.primary.withOpacity(0.05),
                ),
                columns: [
                  DataColumn2(
                    label: Text(
                      'Tiêu đề',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Khu vực',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Kinh nghiệm',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Text(
                      'Cập nhật',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    size: ColumnSize.S,
                  ),
                ],
                rows: state.tuyenDungList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tuyenDung = entry.value;
                  final isEven = index % 2 == 0;

                  return DataRow(
                    color: MaterialStateProperty.all(
                      isEven
                          ? Colors.transparent
                          : theme.colorScheme.primary.withOpacity(0.02),
                    ),
                    cells: [
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tuyenDung.tdTieude ?? 'Chưa có',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (tuyenDung.tdSoluong != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  'SL: ${tuyenDung.tdSoluong}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
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
                                  'motaCongViec':
                                      tuyenDung.tdMotacongviec ?? '',
                                  'ngayNhanHoSo': tuyenDung.ngayNhanHoSo ?? '',
                                  'tenNTD': tuyenDung.tdTieude ?? '',
                                  'address': tuyenDung.noiLamviec ?? '',
                                  'idDoanhNghiep':
                                      tuyenDung.idDoanhNghiep.toString(),
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tuyenDung.noiLamviec ?? 'Chưa có',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          _getKinhNghiemName(tuyenDung.idKinhnghiem),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          tuyenDung.modifiredDate != null
                              ? _formatDate(tuyenDung.modifiredDate)
                              : 'Chưa có',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
