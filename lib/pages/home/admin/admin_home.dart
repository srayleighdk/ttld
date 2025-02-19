import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';

class AdminHomePage extends StatelessWidget {
  static const routePath = '/admin/home';
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        centerTitle: true,
      ),
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

            // Section 3: Báo cáo thống kê
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
        const Text(
          'Quick Access',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildQuickAccessButton(
              icon: FontAwesomeIcons.userGroup,
              label: 'Manage Group',
              onPressed: () {
                context.go('/manager-group');
                // Navigate to manage users page
              },
            ),
            _buildQuickAccessButton(
              icon: FontAwesomeIcons.userPen,
              label: 'Manger Users',
              onPressed: () {
                // Navigate to settings page
              },
            ),
            _buildQuickAccessButton(
              icon: Icons.notifications,
              label: 'Notifications',
              onPressed: () {
                // Navigate to notifications page
              },
            ),
            _buildQuickAccessButton(
              icon: Icons.report,
              label: 'Reports',
              onPressed: () {
                // Navigate to reports page
              },
            ),
          ],
        ),
      ],
    );
  }

  // Quick Access Button Widget
  Widget _buildQuickAccessButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section 3: Báo cáo thống kê
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
