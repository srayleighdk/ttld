import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/app_init.dart' show initializeAppData;
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/pages/home/admin/admin_home.dart';
import 'package:ttld/pages/home/custom_bottom_nav_bar.dart';
import 'package:ttld/pages/home/notification_page.dart';
import 'package:ttld/pages/home/ntd/ntd_home.dart';
import 'package:ttld/pages/home/ntv/ntv_home.dart';
import 'package:ttld/pages/home/profile_page.dart';
import 'package:ttld/pages/home/lien_he_page.dart';
import 'package:ttld/widgets/logout_button.dart';

enum UserRole { admin, ntd, ntv }

class HomePage extends StatefulWidget {
  final String userId;
  final String userType;
  final Region region;
  const HomePage(
      {super.key,
      required this.userId,
      required this.userType,
      required this.region});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  UserRole? _role;
  late final List<Widget> _pages;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await _initializeAppData();
      if (mounted) {
        _initializeUserData();
      }
    } catch (e) {
      // Handle initialization error
      debugPrint('Initialization error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  Future<void> _initializeAppData() async {
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

  Widget _wrapWithAppBar({required String title, required Widget child}) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 1.0,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        actions: [
          LogoutButton(),
        ],
      ),
      body: child,
    );
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
      _wrapWithAppBar(title: 'Trang chủ', child: homePage),
      _wrapWithAppBar(title: 'Thông báo', child: const NotificationsPage()),
      _wrapWithAppBar(title: 'Hồ sơ', child: profilePage),
      _wrapWithAppBar(
          title: 'Liên hệ', child: LienHePage(region: widget.region)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
          child: _isInitializing || _role == null || _pages.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                ),
        ),
      ),
      bottomNavigationBar: _isInitializing || _role == null || _pages.isEmpty
          ? null
          : Theme(
              data: Theme.of(context).copyWith(
                navigationBarTheme: NavigationBarThemeData(
                  labelTextStyle: WidgetStateProperty.all(
                    TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  iconTheme: WidgetStateProperty.all(
                    IconThemeData(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  backgroundColor: theme.colorScheme.surface,
                  indicatorColor: theme.colorScheme.primary.withAlpha(25),
                  elevation: 8,
                  surfaceTintColor: theme.colorScheme.surface,
                ),
              ),
              child: CustomNavigationBar(
                currentIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
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

    return Container(
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics Overview',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _AnalyticItem(
            icon: FontAwesomeIcons.userTie,
            label: 'Total Applicants',
            value: '156',
            color: theme.colorScheme.primary,
          ),
          const Divider(height: 24),
          _AnalyticItem(
            icon: FontAwesomeIcons.briefcase,
            label: 'Active Job Posts',
            value: '12',
            color: theme.colorScheme.secondary,
          ),
          const Divider(height: 24),
          _AnalyticItem(
            icon: FontAwesomeIcons.eye,
            label: 'Profile Views',
            value: '1,234',
            color: theme.colorScheme.tertiary,
          ),
        ],
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
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
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
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(179),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
