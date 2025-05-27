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
          label: 'Trang chủ',
          icon: FontAwesomeIcons.house,
          selectedIcon: FontAwesomeIcons.house,
        ),
        _buildNavigationDestination(
          label: 'Thông báo',
          icon: FontAwesomeIcons.bell,
          selectedIcon: FontAwesomeIcons.solidBell,
        ),
        _buildNavigationDestination(
          label: 'Hồ sơ',
          icon: FontAwesomeIcons.user,
          selectedIcon: FontAwesomeIcons.solidUser,
        ),
        _buildNavigationDestination(
          label: 'Liên hệ',
          icon: FontAwesomeIcons.solidEnvelope,
          selectedIcon: FontAwesomeIcons.envelope,
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
