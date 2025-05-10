import 'package:flutter/material.dart';
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
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  void _initializeBlocs() {
    // Get fresh instances from locator
    _hoSoUngVienBloc = locator<NTVBloc>();
    _ntdBloc = locator<NTDBloc>();

    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      userId = authState.userId;
      // Load NTD data
      if (!_ntdBloc.isClosed) {
        _ntdBloc.add(NTDFetchById(int.parse(userId!)));
      }
    }
    if (!_hoSoUngVienBloc.isClosed) {
      _hoSoUngVienBloc.add(LoadTblHoSoUngViens());
    }
  }

  @override
  void dispose() {
    // Don't close the blocs here since they are managed by the locator
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildUserInfoSection(context, ntdState),
                            const SizedBox(height: 32.0),
                            _buildQuickAccessSection(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
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
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                  child: ntd.imagePath != null && ntd.imagePath!.isNotEmpty
                      ? Image.network(
                          '${getEnv('URL_AVATAR')}${ntd.imagePath}',
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
                    style: theme.textTheme.headlineSmall?.copyWith(
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

  // Section 2: Quick Access Buttons
  Widget _buildQuickAccessSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                'Danh mục chức năng',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.solidPenToSquare,
                label: 'Cập nhật NTD',
                route: '/update_ntd',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.fileImport,
                label: 'Hồ sơ chắp nối',
                route: '/ntd_home/ho-so-chap-noi',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.calendarPlus,
                label: 'Thêm tuyển dụng',
                route: '/ntd_home/create_tuyen_dung',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.calendarCheck,
                label: 'Quản Lý Tuyển Dụng',
                route: '/ntd_home/quan-ly-tuyen-dung',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.calendarCheck,
                label: 'Quản Lý Nhân Viên',
                route: '/ntd_home/quan-ly-nhan-vien',
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
    required String label,
    required String route,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withAlpha(26),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          try {
            if (route == '/ntd_home/ho-so-chap-noi') {
              context.push(route, extra: {
                'id': userId,
                'ntdUsername': ntd?.username,
              });
            } else if (route == '/ntd_home/quan-ly-tuyen-dung') {
              context.push(route, extra: userId);
            } else {
              context.push(route);
            }
          } catch (e) {
            print('Navigation error: $e');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8.0),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
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

  Widget _buildStatisticsSection(BuildContext context, NTVState state) {
    if (state is NTVError) {
      return Center(child: Text(state.message));
    }
    if (state is NTVLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withAlpha(26),
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
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Danh sách người tìm việc',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: DataTable2(
                columnSpacing: 0,
                horizontalMargin: 12,
                minWidth: 900,
                headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                ),
                columns: [
                  DataColumn2(
                    label: Text(
                      'Họ tên',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Giới tính',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Tuổi',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Ngành nghề',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                ],
                rows: state.tblHoSoUngViens.map((hoSo) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        hoSo.uvHoten ?? 'Chưa có',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                      DataCell(Text(
                        hoSo.uvGioitinh == 1 ? 'Nam' : 'Nữ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                      DataCell(Text(
                        _calculateAge(hoSo.uvNgaysinh)?.toString() ?? 'Chưa có',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                      DataCell(Text(
                        hoSo.uvnvNganhnghe ?? 'Chưa có',
                        style: Theme.of(context).textTheme.bodyMedium,
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
    if (birthDate == null) return null;
    try {
      final birth = DateTime.parse(birthDate);
      final today = DateTime.now();
      int age = today.year - birth.year;
      if (today.month < birth.month ||
          (today.month == birth.month && today.day < birth.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return null;
    }
  }
}
