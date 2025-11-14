import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

/// Example page showcasing different AppBar variants
/// This file demonstrates how to use the various AppBar components
class AppBarExamplesPage extends StatelessWidget {
  const AppBarExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'AppBar Examples',
        useGradient: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExampleCard(
            context,
            'Default CustomAppBar',
            'Modern gradient design with rounded back button',
            () => _showExamplePage(
              context,
              const CustomAppBar(title: 'Default AppBar'),
              'This is the default CustomAppBar with gradient background.',
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'HomeAppBar',
            'For home pages with search and notifications',
            () => _showExamplePage(
              context,
              HomeAppBar(
                title: 'Welcome Back',
                subtitle: 'Good morning!',
                avatar: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withAlpha(51),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                onSearchPressed: () {},
                onNotificationPressed: () {},
              ),
              'This is the HomeAppBar with avatar, subtitle, search and notification buttons.',
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'ProfileAppBar',
            'For profile and settings pages',
            () => _showExamplePage(
              context,
              ProfileAppBar(
                title: 'Profile Settings',
                onEditPressed: () {},
                onSettingsPressed: () {},
              ),
              'This is the ProfileAppBar with edit and settings buttons.',
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'FormAppBar',
            'For form pages with save functionality',
            () => _showExamplePage(
              context,
              FormAppBar(
                title: 'Create New Item',
                onSavePressed: () {},
                isLoading: false,
              ),
              'This is the FormAppBar with save button. Set isLoading to true to show loading state.',
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'TransparentAppBar',
            'For transparent backgrounds',
            () => _showExamplePage(
              context,
              const TransparentAppBar(
                title: 'Transparent AppBar',
              ),
              'This is the TransparentAppBar for use over custom backgrounds.',
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'Custom Colors',
            'AppBar with custom colors',
            () => _showExamplePage(
              context,
              const CustomAppBar(
                title: 'Custom Colors',
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                useThemeColors: false,
              ),
              'This is a CustomAppBar with custom background and foreground colors.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  FontAwesomeIcons.palette,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.colorScheme.onSurface.withAlpha(128),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExamplePage(
    BuildContext context,
    PreferredSizeWidget appBar,
    String content,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AppBar Demo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.lightbulb,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Notice how the AppBar has a modern gradient design with rounded action buttons and enhanced styling.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}