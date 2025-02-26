import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';

class NTVHomePage extends StatefulWidget {
  const NTVHomePage({Key? key});

  static const String routePath = '/ntv_home';

  @override
  State<NTVHomePage> createState() => _NTVHomePageState();
}

class _NTVHomePageState extends State<NTVHomePage> {
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

            // Section 3: NTV Information (Placeholder)
            _buildNTVInfoSection(context),
            const SizedBox(height: 24.0),

            // Section 4: Statistics
            _buildStatisticsSection(),
          ],
        ),
      ),
    );
  }

  // Section 1: User Information
  Widget _buildUserInfoSection(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
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
            label: 'Cập nhật NTV',
            route: '/update_ntv',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.fileImport,
            label: 'Tìm Kiếm Việc Làm',
            route: '/tim-kiem-viec-lam',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.calendarPlus,
            label: 'Nộp Hồ Sơ',
            route: '/nop-ho-so',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.calendarCheck,
            label: 'Quản Lý Hồ Sơ',
            route: '/quan-ly-ho-so',
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
            print('Button tapped');
            print('Current route: ${GoRouterState.of(context).uri.path}');
            print('Attempting to navigate to: $route');
            try {
              context.push(route); // Changed from context.go to context.push
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

  // Section 3: NTV Information (Placeholder)
  Widget _buildNTVInfoSection(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin NTV',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Tên: N/A'),
            Text('Email: N/A'),
          ],
        ),
      ),
    );
  }

  // Section 4: Statistics
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
