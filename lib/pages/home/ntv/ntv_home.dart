import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/bloc/tuyendung/tuyendung_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/bloc/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';

class NTVHomePage extends StatefulWidget {
  const NTVHomePage({
    super.key,
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

  String _formatDate(DateTime? date) {
    if (date == null) return 'Chưa có';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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

    _kinhNghiemBloc =
        KinhNghiemLamViecBloc(locator<KinhNghiemLamViecRepository>());
    _kinhNghiemBloc.add(FetchKinhNghiemLamViecList());
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return MultiBlocListener(
      listeners: [
        BlocListener<NTVBloc, NTVState>(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: size.height,
          width: size.width,
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<TuyenDungBloc, TuyenDungState>(
                bloc: _tuyenDungBloc,
                builder: (context, tuyenDungState) {
                  if (_isInitialLoading && tuyenDungState is TuyenDungLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      // Top section with user info and quick access
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildUserInfoSection(context),
                            const SizedBox(height: 32.0),
                            _buildQuickAccessSection(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      // Statistics section
                      Expanded(
                        child: _buildStatisticsSection(context, tuyenDungState),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Section 1: User Information
  Widget _buildUserInfoSection(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: locator<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state;
          return Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.05),
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
                      child: tblHoSoUngVien?.avatarUrl != null &&
                              tblHoSoUngVien!.avatarUrl!.isNotEmpty
                          ? Image.network(
                              '${getEnv('URL_AVATAR')}${tblHoSoUngVien?.avatarUrl}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint('Error loading avatar: $error');
                                return Center(
                                  child: Text(
                                    user.userName[0].toUpperCase(),
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
                                user.userName[0].toUpperCase(),
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
                        user.userName,
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
        } else {
          return const Center(child: Text('User not logged in'));
        }
      },
    );
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
                color: theme.colorScheme.shadow.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
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
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.05),
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
                label: 'Cập nhật NTV',
                route: '/ntv_home/update_ntv',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.fileImport,
                label: 'Hồ sơ chắp nối',
                route: '/ntv_home/ho-so-chap-noi',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.calendarPlus,
                label: 'Đăng ký tìm việc',
                route: '/ntv_home/dang-ky-lam-viec',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.calendarCheck,
                label: 'Đăng ký tư vấn việc làm',
                route: '/ntv_home/dang-ky-tu-van-viec-lam',
              ),
              _buildQuickAccessButton(
                context: context,
                icon: FontAwesomeIcons.graduationCap,
                label: 'Đăng ký học nghề',
                route: '/ntv_home/dang-ky-hoc-nghe',
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
            if (route == '/ntv_home/update_ntv') {
              context.push(route, extra: tblHoSoUngVien);
            } else if (route == '/ntv_home/ho-so-chap-noi') {
              context.push(route, extra: {
                'id': tblHoSoUngVien?.id,
                'uvUsername': tblHoSoUngVien?.uvUsername,
              });
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

  Widget _buildStatisticsSection(BuildContext context, TuyenDungState state) {
    if (state is TuyenDungError) {
      return Center(
        child: Text(
          state.message,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      );
    }

    if (state is TuyenDungLoaded) {
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
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
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
                  'Danh sách tuyển dụng',
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
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1200,
                headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                ),
                columns: [
                  DataColumn2(
                    label: Text(
                      'Tiêu đề',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Khu vực',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Kinh nghiệm',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Cập nhật',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.S,
                  ),
                ],
                rows: state.tuyenDungList
                    .map((tuyenDung) => DataRow(
                          cells: [
                            DataCell(Text(
                              tuyenDung.tdTieude ?? 'Chưa có',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                            DataCell(Text(
                              tuyenDung.noiLamviec ?? 'Chưa có',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                            DataCell(Text(
                              _getKinhNghiemName(tuyenDung.idKinhnghiem),
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                            DataCell(Text(
                              tuyenDung.modifiredDate != null
                                  ? _formatDate(tuyenDung.modifiredDate)
                                  : 'Chưa có',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
