import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/pages/home/custom_bottom_nav_bar.dart';
import 'package:ttld/pages/home/notification_page.dart';
import 'package:ttld/pages/home/ntv/profile_page.dart';
import 'package:ttld/pages/home/search_page.dart';
import 'package:ttld/widgets/custom_quick_link.dart';
import 'package:ttld/widgets/custom_user_profile.dart';
import 'package:ttld/widgets/logout_button.dart';

class NTVHomePage extends StatefulWidget {
  const NTVHomePage({super.key});

  static const String routePath = '/ntv_home';

  @override
  State<NTVHomePage> createState() => _NTVHomePageState();
}

class _NTVHomePageState extends State<NTVHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const SearchPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NTV Home'),
        actions: const [LogoutButton()],
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => GoRouter.of(context).pop(),
        // ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onDestinationSelected: (index) {
          // Handle post button separately if needed
          if (index == 2) {
            // Show post creation dialog or navigate to post page
            // _showPostDialog();
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      ProfileSection(),
      SizedBox(height: 24),
      CustomQuickLink(
        items: [
          QuickLinkItem(
            icon: FontAwesomeIcons.userPen,
            label: 'Home',
            onPressed: () {
              // Handle home button press
              context.go('/ntv_home/manager-group');
              print("Home Pressed");
            },
          ),
          QuickLinkItem(
            icon: Icons.search,
            label: 'Search',
            onPressed: () {
              // Handle search button press
              print("Search Pressed");
            },
          ),
          QuickLinkItem(
            icon: Icons.person,
            label: 'Profile',
            onPressed: () {
              // Handle profile button press
              print("Profile Pressed");
            },
          ),
          QuickLinkItem(
            icon: Icons.settings,
            label: '', // Empty label - only icon will be shown
            onPressed: () {
              // Handle settings button press
              print("Settings Pressed");
            },
          ),
        ],
      )
    ]);
  }
}
