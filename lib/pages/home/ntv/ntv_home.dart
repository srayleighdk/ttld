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
import 'package:ttld/pages/home/ntd/ntd_tuyendung_info_page.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/bloc/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:ttld/core/enums/region.dart'; // Import Region enum

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
  String _avatarBaseUrl = ''; // Variable to store the avatar base URL

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfoSection(context),
                    const SizedBox(height: 12.0),
                    _buildQuickAccessSection(context),
                    const SizedBox(height: 12.0),
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
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: locator<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state;
          return InkWell(
            onTap: () {
              // Navigate to ProfilePage, passing userId and userType
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userId: user.userId,
                    userType: user.userType,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12), // Match container border radius
            child: Container(
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
                        width: 40,
                        height: 40,
                        color: theme.colorScheme.surface,
                        child: _avatarBaseUrl.isNotEmpty &&
                                tblHoSoUngVien?.avatarUrl != null &&
                                tblHoSoUngVien!.avatarUrl!.isNotEmpty
                            ? Image.network(
                                '$_avatarBaseUrl${tblHoSoUngVien?.avatarUrl}', // Use the dynamic URL
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint('Error loading avatar: $error');
                                  return Center(
                                    child: Text(
                                      user.userName[0].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
            ),
          );
        } else {
          return const Center(child: Text('User not logged in'));
        }
      },
    );
  }

  Widget _buildQuickAccessSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Only the title row remains in a Container
        Container(
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
        const SizedBox(height: 12),
        // Show the quick access items directly, not inside another container
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
            mainAxisSpacing: 8,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9, // Adjusted aspect ratio for more height
            children: [
              _buildQuickAccessItem(context, FontAwesomeIcons.solidPenToSquare,
                  'Cập nhật NTV', '/ntv_home/update_ntv'),
              _buildQuickAccessItem(context, FontAwesomeIcons.fileImport,
                  'Hồ sơ chắp nối', '/ntv_home/ho-so-chap-noi'),
              _buildQuickAccessItem(context, FontAwesomeIcons.calendarPlus,
                  'Đăng ký tìm việc', '/ntv_home/dang-ky-lam-viec'),
              _buildQuickAccessItem(
                  context,
                  FontAwesomeIcons.calendarCheck,
                  'Đăng ký tư vấn việc làm',
                  '/ntv_home/dang-ky-tu-van-viec-lam'),
              _buildQuickAccessItem(context, FontAwesomeIcons.graduationCap,
                  'Đăng ký học nghề', '/ntv_home/dang-ky-hoc-nghe'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildQuickAccessButton(context: context, icon: icon, route: route),
        const SizedBox(height: 2),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton({
    required BuildContext context,
    required IconData icon,
    required String route,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withAlpha(26),
                  blurRadius: 8,
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
                columnSpacing: 8,
                horizontalMargin: 8,
                minWidth: 500,
                headingRowHeight: 40,
                dataRowHeight: 40,
                columns: [
                  DataColumn2(
                    label: Text(
                      'Tiêu đề',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    size: ColumnSize.L,
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
                    size: ColumnSize.M,
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
                            DataCell(
                              Text(
                                tuyenDung.tdTieude ?? 'Chưa có',
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                        'ngayNhanHoSo':
                                            tuyenDung.ngayNhanHoSo ?? '',
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
