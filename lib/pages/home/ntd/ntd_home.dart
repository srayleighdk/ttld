import 'package:flutter/material.h';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
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

                  return Column(
                    children: [
                      // Top section with user info and quick access
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUserInfoSection(context, ntdState),
                          const SizedBox(height: 12.0),
                          _buildKeyActionButtonsSection(context), // NEW SECTION
                          const SizedBox(
                              height: 12.0), // Spacing after new section
                          _buildQuickAccessSection(context),
                        ],
                      ),
                      const SizedBox(height: 12.0), // Reduced from 32.0
                      // Statistics section
                      Expanded(
                        child: _buildStatisticsSection(context, ntvState),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Section 1: User Information
  Widget _buildUserInfoSection(BuildContext context, NTDState state) {
    final theme = Theme.of(context);
    if (state is NTDLoadedById) {
      final ntd = state.ntd;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withAlpha(26),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withAlpha(204),
                  ],
                ),
              ),
              child: ClipOval(
                child: Container(
                  width: 60,
                  height: 60,
                  color: theme.colorScheme.surface,
                  child: _avatarBaseUrl.isNotEmpty &&
                          ntd.imagePath != null &&
                          ntd.imagePath!.isNotEmpty
                      ? Image.network(
                          '$_avatarBaseUrl${ntd.imagePath}', // Use the dynamic URL
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error loading avatar: $error');
                            return Center(
                              child: Text(
                                (ntd.ntdTen ?? 'U')[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            (ntd.ntdTen ?? 'U')[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(179),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ntd.ntdTen ?? 'Unknown Company',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (state is NTDError) {
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return const SizedBox.shrink();
    }
  }

  // New section for key action buttons (similar to NTV's action buttons)
  Widget _buildKeyActionButtonsSection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildKeyActionButtonItem(context, FontAwesomeIcons.store, 'Sàn GDVL',
              null), // Added Sàn GDVL button
          _buildKeyActionButtonItem(context, FontAwesomeIcons.calendarPlus,
              'Thêm tuyển dụng', '/ntd_home/create_tuyen_dung'),
          _buildKeyActionButtonItem(context, FontAwesomeIcons.fileImport,
              'Hồ sơ chắp nối', '/ntd_home/ho-so-chap-noi'),
          // Add more key actions here if needed
        ],
      ),
    );
  }

  // Helper widget for each key action button item
  Widget _buildKeyActionButtonItem(
      BuildContext context, IconData icon, String label, String? route) {
    final theme = Theme.of(context);
    return Expanded(
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
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red, // Red background as in NTV
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: 11,
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

  // Section 2: Quick Access Buttons (now with fewer items)
  Widget _buildQuickAccessSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(26),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 16, // Reduced from 24
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
              const SizedBox(width: 8), // Reduced from 12
              Expanded(
                child: Text(
                  'Dịch vụ việc làm',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8), // Reduced from 16
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(26),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: [
              _buildQuickAccessItem(context, FontAwesomeIcons.solidPenToSquare,
                  'Cập nhật TT, phiếu TT tuyển dụng', '/update_ntd'),
              _buildQuickAccessItem(context, FontAwesomeIcons.calendarCheck,
                  'Quản Lý Tuyển Dụng', '/ntd_home/quan-ly-tuyen-dung'),
              _buildQuickAccessItem(context, FontAwesomeIcons.calendarCheck,
                  'Quản Lý Nhân Viên', '/ntd_home/quan-ly-nhan-vien'),
              _buildQuickAccessItem(context, FontAwesomeIcons.globe,
                  'TD lao động nước ngoài', null),
              _buildQuickAccessItem(context, FontAwesomeIcons.envelopeOpenText,
                  'Thư mời tham gia GDVL', null),
              _buildQuickAccessItem(context, FontAwesomeIcons.handshake,
                  'Kết quả kết nối việc làm', null),
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

  Widget _buildQuickAccessItem(
      BuildContext context, IconData icon, String label, String? route) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 104,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuickAccessButton(context: context, icon: icon, route: route),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // String _formatDate(DateTime? date) {
  //   if (date == null) return '';
  //   return '${date.day}/${date.month}/${date.year}';
  // }

  Widget _buildStatisticsSection(BuildContext context, NTVState state) {
    if (state is NTVError) {
      return Center(child: Text(state.message));
    }
    if (state is NTVLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4), // Reduced padding
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8), // Reduced radius
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withAlpha(20),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 3, // Reduced width
                  height: 16, // Reduced height
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Danh sách người tìm việc',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: DataTable2(
                columnSpacing: 4, // Reduced spacing
                horizontalMargin: 8,
                minWidth: 300, // Reduced minimum width
                headingRowHeight: 32, // Reduced header height
                dataRowHeight: 36, // Reduced row height
                headingTextStyle:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                dividerThickness: 0.5, // Reduced divider thickness
                columns: [
                  DataColumn2(
                    label: Text('Họ tên'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text('Giới tính'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Tuổi'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Ngành nghề'),
                    size: ColumnSize.L,
                  ),
                ],
                rows: state.tblHoSoUngViens.map((hoSo) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: 80,
                              minWidth: 80), // Reduced constraints
                          child: Text(
                            hoSo.uvHoten ?? 'Chưa có',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
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
                      DataCell(Container(
                        constraints: BoxConstraints(
                            maxWidth: 50, minWidth: 50), // Reduced constraints
                        child: Text(
                          hoSo.uvGioitinh == 1 ? 'Nam' : 'Nữ',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 11,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataCell(Container(
                        constraints: BoxConstraints(
                            maxWidth: 40, minWidth: 40), // Reduced constraints
                        child: Text(
                          _calculateAge(hoSo.uvNgaysinh)?.toString() ??
                              'Chưa có',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 11,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataCell(Container(
                        constraints: BoxConstraints(
                            maxWidth: 70, minWidth: 70), // Reduced constraints
                        child: Text(
                          hoSo.uvnvNganhnghe ?? 'Chưa có',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 11,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
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
