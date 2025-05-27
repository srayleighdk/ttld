import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';

class AdminHomePage extends StatelessWidget {
  static const routePath = '/admin/home';
  const AdminHomePage({super.key});

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
        _buildSectionHeader('Hệ Thống'),
        _buildQuickAccessRow(context, [
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.gear,
            label: 'Log Hệ Thống',
            route: '/log-he-thong',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.lock,
            label: 'Phân Quyền',
            route: '/phan-quyen',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.database,
            label: 'Quản Trị Dữ Liệu',
            route: '/quan-tri-du-lieu',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.usersGear,
            label: 'Quản Trị Người Dùng',
            route: '/quan-tri-nguoi-dung',
          ),
        ]),
        _buildSectionHeader('Danh Mục'),
        _buildQuickAccessRow(context, [
          // Add your "Danh Mục" quick links here
          _buildQuickAccessButton(
            context: context,
            icon: Icons.category,
            label: 'Danh Mục 1',
            route: '/danh-muc-1',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: Icons.category,
            label: 'Danh Mục 2',
            route: '/danh-muc-2',
          ),
        ]),
        _buildSectionHeader('Thu Thập Thông Tin'),
        _buildQuickAccessRow(context, [
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.building,
            label: 'Hồ Sơ Cơ Quan Quản Lý',
            route: '/ho-so-co-quan',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.user,
            label: 'Hồ Sơ Người Lao Động',
            route: '/ho-so-nguoi-lao-dong',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.building,
            label: 'Hồ Sơ Nhà Tuyển Dụng',
            route: '/ho-so-nha-tuyen-dung',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.briefcase,
            label: 'Theo Dõi Việc Làm',
            route: '/theo-doi-viec-lam',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.wheelchair,
            label: 'Lao Động Khuyết Tật',
            route: '/lao-dong-khuyet-tat',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.fileContract,
            label: 'Đối Soát Mẫu',
            route: '/doi-soat-mau',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.chartBar,
            label: 'Báo Cáo Hoạt Động',
            route: '/bao-cao-hoat-dong',
          ),
        ]),
        _buildSectionHeader('Nghiệp Vụ'),
        _buildQuickAccessRow(context, [
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.idCard,
            label: 'Hồ Sơ Ứng Viên',
            route: '/ho-so-ung-vien',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.city,
            label: 'Hồ Sơ Doanh Nghiệp',
            route: '/ho-so-doanh-nghiep',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.handshake,
            label: 'Hồ Sơ Chắp Nối',
            route: '/ho-so-chap-noi',
          ),
          _buildQuickAccessButton(
            context: context,
            icon: FontAwesomeIcons.checkDouble,
            label: 'Giải Quyết Việc Làm',
            route: '/giai-quyet-viec-lam',
          ),
        ]),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
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
          onTap: () => context.push(route),
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
