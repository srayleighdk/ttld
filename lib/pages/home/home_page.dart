import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/app_init.dart' show initializeAppData;
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/pages/home/admin/admin_home.dart';
import 'package:ttld/pages/home/custom_bottom_nav_bar.dart';
import 'package:ttld/pages/home/notification_page.dart';
import 'package:ttld/pages/home/ntd/ntd_home.dart';
import 'package:ttld/pages/home/ntv/ntv_home.dart';
import 'package:ttld/pages/home/profile_page.dart';
import 'package:ttld/pages/home/search_page.dart';
import 'package:ttld/widgets/logout_button.dart';

enum UserRole { admin, ntd, ntv }

class HomePage extends StatefulWidget {
  final String userId;
  final String userType;
  const HomePage({super.key, required this.userId, required this.userType});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  UserRole? _role;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    _initializeAppData();
  }

  void _initializeAppData() async {
    await initializeAppData(); // Preload data
  }

  void _initializeUserData() {
    _role = UserRole.values
        .firstWhere((role) => role.name == widget.userType.toLowerCase());

    // Fetch role-specific data
    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      if (_role == UserRole.ntv) {
        locator<NTVBloc>().add(LoadTblHoSoUngVien(int.parse(widget.userId)));
      } else if (_role == UserRole.ntd) {
        locator<NTDBloc>().add(NTDFetchById(int.parse(widget.userId)));
      }
      // Admin could have its own Bloc if needed
    }

    _pages = _buildPages();
  }

  List<Widget> _buildPages() {
    late final Widget homePage;
    switch (_role) {
      case UserRole.admin:
        homePage = const AdminHomePage();
        break;
      case UserRole.ntd:
        homePage = BlocProvider<NTDBloc>.value(
          value: locator<NTDBloc>(),
          child: const NTDHomePage(),
        );
        break;
      case UserRole.ntv:
        homePage = BlocProvider<NTVBloc>.value(
          value: locator<NTVBloc>(),
          child: const NTVHomePage(),
        );
        break;
      case null:
        homePage = const Center(child: Text('Role not determined'));
        break;
    }

    late final Widget profilePage;
    switch (_role) {
      case UserRole.ntv:
        profilePage = BlocProvider<NTVBloc>.value(
          value: locator<NTVBloc>(),
          child: ProfilePage(userId: widget.userId, userType: widget.userType),
        );
        break;
      case UserRole.ntd:
        profilePage = BlocProvider<NTDBloc>.value(
          value: locator<NTDBloc>(),
          child: ProfilePage(userId: widget.userId, userType: widget.userType),
        );
        break;
      case UserRole.admin:
      case null:
        profilePage =
            ProfilePage(userId: widget.userId, userType: widget.userType);
        break;
    }

    return [
      homePage,
      const SearchPage(),
      const NotificationsPage(),
      profilePage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_role == null || _pages.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [LogoutButton()],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Section 3: Analytics Section
class AnalyticsSection extends StatelessWidget {
  const AnalyticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Overview',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const _AnalyticItem(
              icon: FontAwesomeIcons.userTie,
              label: 'Total Applicants',
              value: '156',
              color: Colors.blue,
            ),
            const Divider(height: 24),
            const _AnalyticItem(
              icon: FontAwesomeIcons.briefcase,
              label: 'Active Job Posts',
              value: '12',
              color: Colors.green,
            ),
            const Divider(height: 24),
            const _AnalyticItem(
              icon: FontAwesomeIcons.eye,
              label: 'Profile Views',
              value: '1,234',
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _AnalyticItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
