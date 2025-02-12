import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 65,
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        _buildNavigationDestination(
          label: 'Home',
          icon: FontAwesomeIcons.house,
          selectedIcon: FontAwesomeIcons.house,
        ),
        _buildNavigationDestination(
          label: 'Search',
          icon: FontAwesomeIcons.magnifyingGlass,
          selectedIcon: FontAwesomeIcons.magnifyingGlass,
          badgeCount: 0, // Add badge if needed
        ),
        // _buildNavigationDestination(
        //   label: 'Post',
        //   icon: FontAwesomeIcons.plus,
        //   selectedIcon: FontAwesomeIcons.plus,
        // ),
        _buildNavigationDestination(
          label: 'Notifications',
          icon: FontAwesomeIcons.bell,
          selectedIcon: FontAwesomeIcons.solidBell,
          badgeCount: 3, // Example badge count
        ),
        _buildNavigationDestination(
          label: 'Profile',
          icon: FontAwesomeIcons.user,
          selectedIcon: FontAwesomeIcons.solidUser,
        ),
      ],
    );
  }

  NavigationDestination _buildNavigationDestination({
    required String label,
    required IconData icon,
    required IconData selectedIcon,
    int? badgeCount,
  }) {
    return NavigationDestination(
      icon: Badge(
        isLabelVisible: badgeCount != null && badgeCount > 0,
        label: Text(
          badgeCount.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        child: FaIcon(
          icon,
          size: 20,
        ),
      ),
      selectedIcon: Badge(
        isLabelVisible: badgeCount != null && badgeCount > 0,
        label: Text(
          badgeCount.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        child: FaIcon(
          selectedIcon,
          size: 20,
        ),
      ),
      label: label,
    );
  }
}
