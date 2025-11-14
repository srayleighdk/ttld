import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Modern Custom AppBar widget with gradient backgrounds and enhanced styling
/// Provides consistent, beautiful app bars across the entire project
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double elevation;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool useThemeColors;
  final bool useGradient;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? titleWidget;
  final double? titleSpacing;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation = 0.0,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.useThemeColors = true,
    this.useGradient = true,
    this.showBackButton = true,
    this.onBackPressed,
    this.titleWidget,
    this.titleSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    // Determine colors based on theme and parameters
    Color effectiveBackgroundColor;
    Color effectiveForegroundColor;
    
    if (useThemeColors) {
      effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.primary;
      effectiveForegroundColor = foregroundColor ?? Colors.white;
    } else {
      effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.surface;
      effectiveForegroundColor = foregroundColor ?? theme.colorScheme.onSurface;
    }

    // Build the custom leading widget
    Widget? effectiveLeading = leading;
    if (leading == null && showBackButton && automaticallyImplyLeading) {
      final canPop = ModalRoute.of(context)?.canPop ?? false;
      if (canPop) {
        effectiveLeading = _buildModernBackButton(context, effectiveForegroundColor);
      }
    }

    // Build actions with modern styling
    List<Widget>? effectiveActions = actions?.map((action) {
      if (action is IconButton) {
        return _buildModernActionButton(action, effectiveForegroundColor);
      }
      return action;
    }).toList();

    return Container(
      decoration: useGradient ? _buildGradientDecoration(theme, effectiveBackgroundColor) : null,
      child: AppBar(
        title: titleWidget ?? (title != null 
          ? Text(
              title!,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: effectiveForegroundColor,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            )
          : null),
        centerTitle: centerTitle,
        elevation: elevation,
        backgroundColor: useGradient ? Colors.transparent : effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: effectiveLeading,
        actions: effectiveActions,
        bottom: bottom,
        titleSpacing: titleSpacing,
        toolbarHeight: kToolbarHeight + 8, // Slightly taller for modern look
        iconTheme: IconThemeData(
          color: effectiveForegroundColor,
          size: 22,
        ),
        actionsIconTheme: IconThemeData(
          color: effectiveForegroundColor,
          size: 22,
        ),
      ),
    );
  }

  /// Builds a modern gradient decoration
  BoxDecoration _buildGradientDecoration(ThemeData theme, Color primaryColor) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryColor,
          primaryColor.withAlpha(230),
          primaryColor.withAlpha(200),
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withAlpha(25),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
    );
  }

  /// Builds a modern back button with enhanced styling
  Widget _buildModernBackButton(BuildContext context, Color foregroundColor) {
    return Container(
      margin: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: foregroundColor.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        iconSize: 20,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Builds modern action buttons with enhanced styling
  Widget _buildModernActionButton(IconButton original, Color foregroundColor) {
    return Container(
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: foregroundColor.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: original.onPressed,
        icon: original.icon,
        iconSize: original.iconSize ?? 20,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Check if two colors are too similar (might cause visibility issues)
  bool _isColorTooSimilar(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    final contrast = (luminance1 + 0.05) / (luminance2 + 0.05);
    
    // WCAG AA standard requires a contrast ratio of at least 4.5:1 for normal text
    // We use 3:1 as minimum for icons to be safe
    return contrast < 3.0 && contrast > 1/3.0;
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + 8 + (bottom?.preferredSize.height ?? 0.0)
  );
}

/// Specialized AppBar for transparent backgrounds with proper contrast
class TransparentAppBar extends CustomAppBar {
  const TransparentAppBar({
    super.key,
    super.title,
    super.actions,
    super.leading,
    super.centerTitle = true,
    super.elevation = 0,
    super.automaticallyImplyLeading = true,
    super.bottom,
    super.foregroundColor,
  }) : super(
    backgroundColor: Colors.transparent,
    useThemeColors: false,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // For transparent backgrounds, we need to ensure good contrast
    // against the likely background color
    Color safeForegroundColor = foregroundColor ?? theme.colorScheme.onSurface;
    
    // If the surface is light, ensure we use a dark foreground
    if (theme.colorScheme.surface.computeLuminance() > 0.7) {
      safeForegroundColor = Colors.black87;
    }
    
    return AppBar(
      title: title != null 
        ? Text(
            title!,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: safeForegroundColor,
            ),
          )
        : null,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: Colors.transparent,
      foregroundColor: safeForegroundColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      actions: actions,
      bottom: bottom,
      iconTheme: IconThemeData(
        color: safeForegroundColor,
      ),
      actionsIconTheme: IconThemeData(
        color: safeForegroundColor,
      ),
    );
  }
}

/// Specialized AppBar for home pages with search functionality\nclass HomeAppBar extends CustomAppBar {\n  final VoidCallback? onSearchPressed;\n  final VoidCallback? onNotificationPressed;\n  final String? subtitle;\n  final Widget? avatar;\n\n  const HomeAppBar({\n    super.key,\n    super.title,\n    this.onSearchPressed,\n    this.onNotificationPressed,\n    this.subtitle,\n    this.avatar,\n    super.backgroundColor,\n    super.foregroundColor,\n    super.useGradient = true,\n  }) : super(\n    showBackButton: false,\n    automaticallyImplyLeading: false,\n  );\n\n  @override\n  Widget build(BuildContext context) {\n    final theme = Theme.of(context);\n    final effectiveForegroundColor = foregroundColor ?? Colors.white;\n\n    return CustomAppBar(\n      titleWidget: _buildHomeTitle(theme, effectiveForegroundColor),\n      actions: [\n        if (onSearchPressed != null)\n          Container(\n            margin: const EdgeInsets.only(right: 4, top: 8, bottom: 8),\n            decoration: BoxDecoration(\n              color: effectiveForegroundColor.withAlpha(25),\n              borderRadius: BorderRadius.circular(12),\n            ),\n            child: IconButton(\n              onPressed: onSearchPressed,\n              icon: const Icon(FontAwesomeIcons.magnifyingGlass),\n              iconSize: 18,\n              style: IconButton.styleFrom(\n                foregroundColor: effectiveForegroundColor,\n                shape: RoundedRectangleBorder(\n                  borderRadius: BorderRadius.circular(12),\n                ),\n              ),\n            ),\n          ),\n        if (onNotificationPressed != null)\n          Container(\n            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),\n            decoration: BoxDecoration(\n              color: effectiveForegroundColor.withAlpha(25),\n              borderRadius: BorderRadius.circular(12),\n            ),\n            child: IconButton(\n              onPressed: onNotificationPressed,\n              icon: const Icon(FontAwesomeIcons.bell),\n              iconSize: 18,\n              style: IconButton.styleFrom(\n                foregroundColor: effectiveForegroundColor,\n                shape: RoundedRectangleBorder(\n                  borderRadius: BorderRadius.circular(12),\n                ),\n              ),\n            ),\n          ),\n      ],\n      backgroundColor: backgroundColor,\n      foregroundColor: foregroundColor,\n      useGradient: useGradient,\n      showBackButton: false,\n      automaticallyImplyLeading: false,\n    );\n  }\n\n  Widget _buildHomeTitle(ThemeData theme, Color foregroundColor) {\n    return Row(\n      children: [\n        if (avatar != null) ..[\n          avatar!,\n          const SizedBox(width: 12),\n        ],\n        Expanded(\n          child: Column(\n            crossAxisAlignment: CrossAxisAlignment.start,\n            mainAxisSize: MainAxisSize.min,\n            children: [\n              if (title != null)\n                Text(\n                  title!,\n                  style: theme.textTheme.titleLarge?.copyWith(\n                    fontWeight: FontWeight.w700,\n                    color: foregroundColor,\n                    fontSize: 20,\n                  ),\n                ),\n              if (subtitle != null)\n                Text(\n                  subtitle!,\n                  style: theme.textTheme.bodyMedium?.copyWith(\n                    color: foregroundColor.withAlpha(204),\n                    fontSize: 14,\n                  ),\n                ),\n            ],\n          ),\n        ),\n      ],\n    );\n  }\n}\n\n/// Specialized AppBar for profile and settings pages\nclass ProfileAppBar extends CustomAppBar {\n  final VoidCallback? onEditPressed;\n  final VoidCallback? onSettingsPressed;\n\n  const ProfileAppBar({\n    super.key,\n    super.title,\n    this.onEditPressed,\n    this.onSettingsPressed,\n    super.backgroundColor,\n    super.foregroundColor,\n    super.useGradient = true,\n  });\n\n  @override\n  Widget build(BuildContext context) {\n    final effectiveForegroundColor = foregroundColor ?? Colors.white;\n\n    return CustomAppBar(\n      title: title,\n      actions: [\n        if (onEditPressed != null)\n          Container(\n            margin: const EdgeInsets.only(right: 4, top: 8, bottom: 8),\n            decoration: BoxDecoration(\n              color: effectiveForegroundColor.withAlpha(25),\n              borderRadius: BorderRadius.circular(12),\n            ),\n            child: IconButton(\n              onPressed: onEditPressed,\n              icon: const Icon(FontAwesomeIcons.penToSquare),\n              iconSize: 18,\n              style: IconButton.styleFrom(\n                foregroundColor: effectiveForegroundColor,\n                shape: RoundedRectangleBorder(\n                  borderRadius: BorderRadius.circular(12),\n                ),\n              ),\n            ),\n          ),\n        if (onSettingsPressed != null)\n          Container(\n            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),\n            decoration: BoxDecoration(\n              color: effectiveForegroundColor.withAlpha(25),\n              borderRadius: BorderRadius.circular(12),\n            ),\n            child: IconButton(\n              onPressed: onSettingsPressed,\n              icon: const Icon(FontAwesomeIcons.gear),\n              iconSize: 18,\n              style: IconButton.styleFrom(\n                foregroundColor: effectiveForegroundColor,\n                shape: RoundedRectangleBorder(\n                  borderRadius: BorderRadius.circular(12),\n                ),\n              ),\n            ),\n          ),\n      ],\n      backgroundColor: backgroundColor,\n      foregroundColor: foregroundColor,\n      useGradient: useGradient,\n    );\n  }\n}\n\n/// Specialized AppBar for form pages\nclass FormAppBar extends CustomAppBar {\n  final VoidCallback? onSavePressed;\n  final bool showSaveButton;\n  final bool isLoading;\n\n  const FormAppBar({\n    super.key,\n    super.title,\n    this.onSavePressed,\n    this.showSaveButton = true,\n    this.isLoading = false,\n    super.backgroundColor,\n    super.foregroundColor,\n    super.useGradient = true,\n  });\n\n  @override\n  Widget build(BuildContext context) {\n    final effectiveForegroundColor = foregroundColor ?? Colors.white;\n\n    return CustomAppBar(\n      title: title,\n      actions: [\n        if (showSaveButton)\n          Container(\n            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),\n            decoration: BoxDecoration(\n              color: effectiveForegroundColor.withAlpha(25),\n              borderRadius: BorderRadius.circular(12),\n            ),\n            child: IconButton(\n              onPressed: isLoading ? null : onSavePressed,\n              icon: isLoading \n                ? SizedBox(\n                    width: 18,\n                    height: 18,\n                    child: CircularProgressIndicator(\n                      strokeWidth: 2,\n                      valueColor: AlwaysStoppedAnimation<Color>(effectiveForegroundColor),\n                    ),\n                  )\n                : const Icon(FontAwesomeIcons.floppyDisk),\n              iconSize: 18,\n              style: IconButton.styleFrom(\n                foregroundColor: effectiveForegroundColor,\n                shape: RoundedRectangleBorder(\n                  borderRadius: BorderRadius.circular(12),\n                ),\n              ),\n            ),\n          ),\n      ],\n      backgroundColor: backgroundColor,\n      foregroundColor: foregroundColor,\n      useGradient: useGradient,\n    );\n  }\n}