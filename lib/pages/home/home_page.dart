import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/router/app_router.dart';
import 'package:ttld/pages/home/custom_bottom_nav_bar.dart';
import 'package:ttld/pages/home/notification_page.dart';
import 'package:ttld/pages/home/profile_page.dart';
import 'package:ttld/pages/home/search_page.dart';
import 'package:ttld/widgets/custom_user_profile.dart';
import 'package:ttld/widgets/logout_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: const Text('Home'),
        actions: const [LogoutButton()],
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
            _showPostDialog();
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _showPostDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PostCreationSheet(),
    );
  }
}

class PostCreationSheet extends StatelessWidget {
  const PostCreationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Create Post',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.briefcase),
            title: const Text('Create Job Post'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to job post creation
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.newspaper),
            title: const Text('Create Article'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to article creation
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ProfileSection(),
        SizedBox(height: 24),
        ActionButtonsSection(),
        SizedBox(height: 24),
        AnalyticsSection(),
      ],
    );
  }
}

// Section 2: Action Buttons
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _ActionButton(
          icon: FontAwesomeIcons.userPen,
          label: 'Edit Profile',
          color: Colors.blue,
          onTap: () {
            // final currentProfileId = context.read<YourBloc>().state.profileId; // Get ID from your state
            // if (currentProfileId != null) {
            //   NavigationService.goToEditProfile(context, currentProfileId);
            // } else {
            //   NavigationService.goToNewProfile(context);
            // }
            // Handle edit profile
            // NavigationService.goToEditProfile(context, 'current_profile_id');
            NavigationService.goToNewProfile(context);
          },
        ),
        _ActionButton(
          icon: FontAwesomeIcons.briefcase,
          label: 'Job Posts',
          color: Colors.green,
          onTap: () {
            // Handle job posts
          },
        ),
        _ActionButton(
          icon: FontAwesomeIcons.chartLine,
          label: 'Analytics',
          color: Colors.purple,
          onTap: () {
            // Handle analytics
          },
        ),
        _ActionButton(
          icon: FontAwesomeIcons.gear,
          label: 'Settings',
          color: Colors.orange,
          onTap: () {
            // Handle settings
          },
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
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
