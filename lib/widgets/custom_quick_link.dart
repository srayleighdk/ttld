import 'package:flutter/material.dart';

class CustomQuickLink extends StatelessWidget {
  final List<QuickLinkItem> items;

  const CustomQuickLink({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Adjust padding as needed
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Background color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
          // Optional shadow
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Distribute buttons evenly
        children: items.map((item) => QuickLinkButton(item: item)).toList(),
      ),
    );
  }
}

class QuickLinkItem {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  QuickLinkItem(
      {required this.icon, required this.label, required this.onPressed});
}

class QuickLinkButton extends StatelessWidget {
  final QuickLinkItem item;

  const QuickLinkButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Make the button tappable
      onTap: item.onPressed,
      borderRadius: BorderRadius.circular(20), // Match the icon's shape
      child: Padding(
        padding:
            const EdgeInsets.all(8.0), // Adjust padding around icon and text
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensure the Column takes up minimal space
          children: [
            Icon(
              item.icon,
              size: 24, // Adjust icon size
              color: Theme.of(context).colorScheme.primary, // Icon color
            ),
            const SizedBox(height: 4), // Spacing between icon and text
            if (item.label.isNotEmpty) // Conditionally show label
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 12, // Adjust text size
                  color: Theme.of(context).colorScheme.onSurface, // Text Color
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Link Example')),
      body: Center(
        child: CustomQuickLink(
          items: [
            QuickLinkItem(
              icon: Icons.home,
              label: 'Home',
              onPressed: () {
                // Handle home button press
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
        ),
      ),
    );
  }
}
