import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class NTDHomePage extends StatefulWidget {
  static const routePath = '/ntd_home';
  const NTDHomePage({super.key});

  @override
  State<NTDHomePage> createState() => _NTDHomePageState();
}

class _NTDHomePageState extends State<NTDHomePage> {
  Ntd? ntd;
  String? userId;
  @override
  void initState() {
    super.initState();
    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      locator<NTDBloc>().add(NTDFetchById(int.parse(authState.userId)));
      userId = authState.userId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: User Information
            _buildUserInfoSection(context),
            const SizedBox(height: 24.0),

            // Section 2: Quick Access Buttons
            _buildQuickAccessSection(context),
            const SizedBox(height: 24.0),

            // // Section 3: NTD Information
            // _buildNTDInfoSection(context),
            // const SizedBox(height: 24.0),

            // Section 4: Báo cáo thống kê
            _buildStatisticsSection(),
          ],
        ),
      ),
    );
  }

  // Section 1: User Information
  Widget _buildUserInfoSection(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: locator<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state;
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: user.avatarUrl != null
                      ? NetworkImage(user.avatarUrl!)
                      : null,
                  child: user.avatarUrl == null
                      ? Text(
                          user.userName[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.userName,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuickAccessRow(context, [
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.solidPenToSquare,
            label: 'Cập nhật NTD',
            route: '/update_ntd',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.fileImport,
            label: 'Nhu cầu tuyển dụng M01TT11',
            route: '/ntd_home/m01tt11',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.calendarPlus,
            label: 'Thêm tuyển dụng mới',
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
        ]),
      ],
    );
  }

  Widget _buildQuickAccessRow(BuildContext context, List<Widget> children) {
    List<Widget> rows = [];
    for (int i = 0; i < children.length; i += 4) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children.sublist(
            i,
            i + 4 > children.length ? children.length : i + 4,
          ),
        ),
      );
    }
    return Column(
      children: rows,
    );
  }

  Widget _buildQuickAccessButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
  }) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Card(
        elevation: 4.0,
        child: InkWell(
          onTap: () {
            try {
              if (route == '/ntd_home/quan-ly-tuyen-dung') {
                context.push(route, extra: userId);
                print('Pushing with userId: $userId');
              } else {
                context.push(route); // Changed from context.go to context.push
              }
            } catch (e) {
              print('Navigation error: $e');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24),
                const SizedBox(height: 4.0),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Section 3: NTD Information
  Widget _buildNTDInfoSection(BuildContext context) {
    return BlocBuilder<NTDBloc, NTDState>(
      bloc: locator<NTDBloc>(),
      builder: (context, state) {
        if (state is NTDLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NTDLoadedById) {
          return Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin NTD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Tên: ${state.ntd.ntdTen ?? 'N/A'}'),
                  Text('Mã DN: ${state.ntd.ntdMadn ?? 'N/A'}'),
                  Text('Email: ${state.ntd.ntdEmail ?? 'N/A'}'),
                ],
              ),
            ),
          );
        } else if (state is NTDError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No NTD data'));
        }
      },
    );
  }

  // Section 4: Báo cáo thống kê
  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Báo cáo thống kê',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Thống kê người dùng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Tổng số người dùng: 100',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Người dùng mới trong tháng: 10',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to detailed statistics page
                  },
                  child: const Text('Xem chi tiết'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
