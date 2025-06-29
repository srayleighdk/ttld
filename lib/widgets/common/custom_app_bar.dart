import 'package:flutter/material.dart';

/// Custom AppBar widget that ensures consistent styling across the app
/// and prevents visibility issues with transparent backgrounds.
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

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation = 1.0,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.useThemeColors = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine colors based on theme and parameters
    Color effectiveBackgroundColor;
    Color effectiveForegroundColor;
    
    if (useThemeColors) {
      // Use theme defaults which are properly configured
      effectiveBackgroundColor = backgroundColor ?? theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface;
      effectiveForegroundColor = foregroundColor ?? theme.appBarTheme.foregroundColor ?? theme.colorScheme.onSurface;
    } else {
      // Use provided colors or safe defaults
      effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.surface;
      effectiveForegroundColor = foregroundColor ?? theme.colorScheme.onSurface;
    }

    // Ensure sufficient contrast - prevent invisible buttons
    if (_isColorTooSimilar(effectiveBackgroundColor, effectiveForegroundColor)) {
      // If colors are too similar, use high contrast alternatives
      if (effectiveBackgroundColor.computeLuminance() > 0.5) {
        // Light background, use dark foreground
        effectiveForegroundColor = Colors.black87;
      } else {
        // Dark background, use light foreground
        effectiveForegroundColor = Colors.white;
      }
    }

    return AppBar(
      title: title != null 
        ? Text(
            title!,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: effectiveForegroundColor,
            ),
          )
        : null,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      actions: actions,
      bottom: bottom,
      iconTheme: IconThemeData(
        color: effectiveForegroundColor,
      ),
      actionsIconTheme: IconThemeData(
        color: effectiveForegroundColor,
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
    kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)
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