import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/pages/home/ntd/ntv_info_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:ttld/core/enums/region.dart'; // Import Region enum

class NTDHomePage extends StatefulWidget {
  static const routePath = '/ntd_home';
  const NTDHomePage({super.key});

  @override
  State<NTDHomePage> createState() => _NTDHomePageState();
}

class _NTDHomePageState extends State<NTDHomePage> {
  Ntd? ntd;
  String? userId;
  String? avatarUrl;
  late NTVBloc _hoSoUngVienBloc;
  late NTDBloc _ntdBloc;
  bool _isInitialLoading = true;
  bool _hasImageError = false;
  String _avatarBaseUrl = ''; // Variable to store the avatar base URL

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
    _loadAvatarBaseUrl(); // Load avatar base URL
  }

  void _initializeBlocs() {
    // Get fresh instances from locator
    _hoSoUngVienBloc = locator<NTVBloc>();
    _ntdBloc = locator<NTDBloc>();

    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      userId = authState.userId;
      print('NTDHomePage initialized with userId: $userId'); // Debug print
      // Load NTD data
      if (!_ntdBloc.isClosed) {
        _ntdBloc.add(NTDFetchById(int.parse(userId!)));
      }
    } else {
      print(
          'Auth state is not authenticated or not ntd type: ${authState.runtimeType}'); // Debug print
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
    // Don't close the blocs here since they are managed by the locator
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Reduced from 24.0 to save space
          child: BlocBuilder<NTDBloc, NTDState>(
            bloc: _ntdBloc,
            builder: (context, ntdState) {
              return BlocBuilder<NTVBloc, NTVState>(
                bloc: _hoSoUngVienBloc,
                builder: (context, ntvState) {
                  if (_isInitialLoading &&
                      (ntdState is NTDLoading || ntvState is NTVLoading)) {
                    return Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (ntdState is NTDLoadedById) {
                    _isInitialLoading = false;
                    ntd = ntdState.ntd;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserInfoSection(context, ntdState),
                        const SizedBox(height: 12.0),
                        _buildKeyActionButtonsSection(context),
                        const SizedBox(height: 12.0),
                        _buildQuickAccessSection(context),
                        const SizedBox(height: 12.0),
                        _buildStatisticsSection(context, ntvState),
                        const SizedBox(
                            height: 100), // Add bottom padding for navbar
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Modern user info section with glass effect and enhanced design
  Widget _buildUserInfoSection(BuildContext context, NTDState state) {
    final theme = Theme.of(context);
    if (state is NTDLoadedById) {
      final ntd = state.ntd;
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
                    width: 70,
                    height: 70,
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
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _avatarBaseUrl.isNotEmpty &&
                              ntd.imagePath != null &&
                              ntd.imagePath!.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                '$_avatarBaseUrl${ntd.imagePath}',
                                width: 66,
                                height: 66,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint('Error loading avatar: $error');
                                  return _buildAvatarFallback(ntd, theme);
                                },
                              ),
                            )
                          : _buildAvatarFallback(ntd, theme),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Company info with enhanced typography
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ntd.ntdTen ?? 'Unknown Company',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                            letterSpacing: 0.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (ntd.ntdDiachichitiet != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                size: 12,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  ntd.ntdDiachichitiet!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Company status indicator
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Active',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (state is NTDError) {
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
    } else {
      return const SizedBox.shrink();
    }
  }

  // Helper method for avatar fallback
  Widget _buildAvatarFallback(Ntd ntd, ThemeData theme) {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.surface,
      ),
      child: Center(
        child: Text(
          (ntd.ntdTen ?? 'U')[0].toUpperCase(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Modern key action buttons section with gradient backgrounds
  Widget _buildKeyActionButtonsSection(BuildContext context) {
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
          _buildKeyActionButtonItem(
            context,
            FontAwesomeIcons.buildingUser,
            'Sàn GDVL',
            '/ntd_home/sgdvl',
            [Color(0xFF4A6FFF), Color(0xFF2E5CFF)], // Blue gradient
          ),
          _buildKeyActionButtonItem(
            context,
            FontAwesomeIcons.plus,
            'Thêm TD',
            '/ntd_home/create_tuyen_dung',
            [Color(0xFF4CAF50), Color(0xFF2E7D32)], // Green gradient
          ),
          _buildKeyActionButtonItem(
            context,
            FontAwesomeIcons.handshake,
            'Chắp Nối',
            '/ntd_home/ho-so-chap-noi',
            [Color(0xFFFF6B6B), Color(0xFFFF4B4B)], // Red gradient
          ),
        ],
      ),
    );
  }

  // Modern key action button item with gradient background
  Widget _buildKeyActionButtonItem(
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
            if (route != null) {
              try {
                if (route == '/ntd_home/ho-so-chap-noi') {
                  context.push(route, extra: {
                    'tabIndex': 0,
                  });
                } else {
                  context.push(route);
                }
              } catch (e) {
                debugPrint('Navigation error: $e');
              }
            }
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

  // Modern quick access section with enhanced design
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
                'Dịch vụ tuyển dụng',
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
            crossAxisCount: 3, // Changed to 3 for better layout
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9, // Adjusted for better proportions
            children: [
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.solidPenToSquare,
                'Cập nhật TT\nPhiếu TT tuyển dụng',
                '/update_ntd',
                [Color(0xFF4A6FFF), Color(0xFF2E5CFF)], // Blue gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.briefcase,
                'Quản Lý\nTuyển Dụng',
                '/ntd_home/quan-ly-tuyen-dung',
                [Color(0xFF4CAF50), Color(0xFF2E7D32)], // Green gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.users,
                'Quản Lý\nNhân Viên',
                '/ntd_home/quan-ly-nhan-vien',
                [Color(0xFFFF6B6B), Color(0xFFFF4B4B)], // Red gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.globe,
                'TD lao động\nnước ngoài',
                null,
                [Color(0xFFFF9800), Color(0xFFF57C00)], // Orange gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.envelopeOpenText,
                'Thư mời\ntham gia GDVL',
                null,
                [Color(0xFF9C27B0), Color(0xFF7B1FA2)], // Purple gradient
              ),
              _buildQuickAccessItem(
                context,
                FontAwesomeIcons.chartLine,
                'Kết quả\nkết nối việc làm',
                null,
                [Color(0xFF00BCD4), Color(0xFF0097A7)], // Cyan gradient
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton({
    required BuildContext context,
    required IconData icon,
    required String? route, // Changed to nullable String
  }) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 40,
      height: 40,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: theme.colorScheme.outline.withAlpha(26),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            if (route != null) {
              try {
                if (route == '/ntd_home/quan-ly-tuyen-dung') {
                  context.push(route, extra: userId);
                } else if (route == '/ntd_home/quan-ly-nhan-vien') {
                  context.push(route, extra: userId);
                } else if (route == '/ntd_home/ho-so-chap-noi') {
                  context.push(route, extra: {
                    'tabIndex': 0,
                  });
                } else {
                  context.push(route);
                }
              } catch (e) {
                debugPrint('Navigation error: $e');
              }
            } else {
              // Handle cases where route is null (e.g., show a message or do nothing)
              debugPrint('Route is null for this quick access item.');
            }
          },
          child: Center(
            child: Icon(
              icon,
              size: 16,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  // Modern quick access item with gradient background and improved visuals
  Widget _buildQuickAccessItem(
    BuildContext context,
    IconData icon,
    String label,
    String? route,
    List<Color> gradientColors,
  ) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (route != null) {
            try {
              if (route == '/ntd_home/quan-ly-tuyen-dung') {
                context.push(route, extra: userId);
              } else if (route == '/ntd_home/quan-ly-nhan-vien') {
                context.push(route, extra: userId);
              } else if (route == '/ntd_home/ho-so-chap-noi') {
                context.push(route, extra: {
                  'tabIndex': 0,
                });
              } else {
                context.push(route);
              }
            } catch (e) {
              debugPrint('Navigation error: $e');
            }
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

  // String _formatDate(DateTime? date) {
  //   if (date == null) return '';
  //   return '${date.day}/${date.month}/${date.year}';
  // }

  // Modern statistics section with enhanced data table design
  Widget _buildStatisticsSection(BuildContext context, NTVState state) {
    final theme = Theme.of(context);

    if (state is NTVError) {
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

    if (state is NTVLoaded) {
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
                    FontAwesomeIcons.users,
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
                        'Ứng viên tiềm năng',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state.tblHoSoUngViens.length} hồ sơ ứng viên',
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
            height: 400, // Fixed height for scrollable content
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
                minWidth: 400,
                headingRowHeight: 56,
                dataRowHeight: 60,
                headingRowColor: WidgetStateProperty.all(
                  theme.colorScheme.primary.withOpacity(0.05),
                ),
                columns: [
                  DataColumn2(
                    label: Text(
                      'Họ tên',
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
                      'Giới tính',
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
                      'Tuổi',
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
                      'Ngành nghề',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    size: ColumnSize.L,
                  ),
                ],
                rows: state.tblHoSoUngViens.asMap().entries.map((entry) {
                  final index = entry.key;
                  final hoSo = entry.value;
                  final isEven = index % 2 == 0;

                  return DataRow(
                    color: WidgetStateProperty.all(
                      isEven
                          ? Colors.transparent
                          : theme.colorScheme.primary.withOpacity(0.02),
                    ),
                    cells: [
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            hoSo.uvHoten ?? 'Chưa có',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NTVInfoPage(ntdData: hoSo),
                            ),
                          );
                        },
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: hoSo.uvGioitinh == 1
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.pink.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            hoSo.uvGioitinh == 1 ? 'Nam' : 'Nữ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: hoSo.uvGioitinh == 1
                                  ? Colors.blue
                                  : Colors.pink,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          _calculateAge(hoSo.uvNgaysinh)?.toString() ??
                              'Chưa có',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          hoSo.uvnvNganhnghe ?? 'Chưa có',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
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

  int? _calculateAge(String? birthDate) {
    if (birthDate == null || birthDate.isEmpty) return null;
    try {
      // Handle different date formats
      DateTime birth;
      if (birthDate.contains('/')) {
        final parts = birthDate.split('/');
        if (parts.length == 3) {
          birth = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } else {
          return null;
        }
      } else {
        birth = DateTime.parse(birthDate);
      }

      final today = DateTime.now();
      int age = today.year - birth.year;
      if (today.month < birth.month ||
          (today.month == birth.month && today.day < birth.day)) {
        age--;
      }
      return age;
    } catch (e) {
      debugPrint('Error calculating age: $e');
      return null;
    }
  }
}
