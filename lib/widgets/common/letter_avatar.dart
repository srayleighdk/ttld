import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A modern letter avatar widget that displays user initials with beautiful colors
/// and handles various edge cases for name parsing and color generation.
class LetterAvatar extends StatelessWidget {
  final String name;
  final double size;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final bool useColorFromName;
  final int maxInitials;
  final String? fallbackText;

  const LetterAvatar({
    super.key,
    required this.name,
    this.size = 40,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.useColorFromName = true,
    this.maxInitials = 2,
    this.fallbackText,
  });

  /// Factory constructor for small avatars (32px)
  factory LetterAvatar.small({
    Key? key,
    required String name,
    Color? backgroundColor,
    Color? textColor,
    String? fallbackText,
  }) {
    return LetterAvatar(
      key: key,
      name: name,
      size: 32,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fallbackText: fallbackText,
    );
  }

  /// Factory constructor for medium avatars (56px)
  factory LetterAvatar.medium({
    Key? key,
    required String name,
    Color? backgroundColor,
    Color? textColor,
    String? fallbackText,
  }) {
    return LetterAvatar(
      key: key,
      name: name,
      size: 56,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fallbackText: fallbackText,
    );
  }

  /// Factory constructor for large avatars (80px)
  factory LetterAvatar.large({
    Key? key,
    required String name,
    Color? backgroundColor,
    Color? textColor,
    String? fallbackText,
  }) {
    return LetterAvatar(
      key: key,
      name: name,
      size: 80,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fallbackText: fallbackText,
    );
  }

  /// Extracts initials from a name string
  String _getInitials(String name) {
    if (name.isEmpty) {
      return fallbackText ?? 'U';
    }

    // Clean and split the name
    final cleanName = name.trim().replaceAll(RegExp(r'[^\p{L}\s]', unicode: true), '');
    if (cleanName.isEmpty) {
      return fallbackText ?? 'U';
    }

    final words = cleanName.split(RegExp(r'\s+'));
    final filteredWords = words.where((word) => word.isNotEmpty).toList();

    if (filteredWords.isEmpty) {
      return fallbackText ?? 'U';
    }

    if (filteredWords.length == 1) {
      // Single word: take first character and second if available
      final word = filteredWords[0];
      if (word.length >= 2) {
        return '${word[0]}${word[1]}'.toUpperCase();
      } else {
        return word[0].toUpperCase();
      }
    } else {
      // Multiple words: take first character of first and last words
      if (filteredWords.length >= 2 && maxInitials >= 2) {
        return '${filteredWords.first[0]}${filteredWords.last[0]}'.toUpperCase();
      } else {
        // Fallback to first maxInitials words if requested or single word
        return filteredWords
            .take(maxInitials)
            .map((word) => word[0])
            .join('')
            .toUpperCase();
      }
    }
  }

  /// Generates a color based on the name string for consistency
  Color _generateColorFromName(String name) {
    if (name.isEmpty) {
      return const Color(0xFF6B73FF); // Default blue
    }

    // Generate a hash from the name
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Use the hash to generate consistent, beautiful colors
    final colors = [
      const Color(0xFF6B73FF), // Blue
      const Color(0xFF9C27B0), // Purple
      const Color(0xFF2196F3), // Light Blue
      const Color(0xFF009688), // Teal
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF9800), // Orange
      const Color(0xFFF44336), // Red
      const Color(0xFF673AB7), // Deep Purple
      const Color(0xFF3F51B5), // Indigo
      const Color(0xFF795548), // Brown
      const Color(0xFF607D8B), // Blue Grey
      const Color(0xFFE91E63), // Pink
      const Color(0xFF00BCD4), // Cyan
      const Color(0xFF8BC34A), // Light Green
      const Color(0xFFFFC107), // Amber
      const Color(0xFFFF5722), // Deep Orange
    ];

    return colors[hash.abs() % colors.length];
  }

  /// Gets text color with good contrast against background
  Color _getContrastingTextColor(Color backgroundColor) {
    // Calculate luminance
    final luminance = backgroundColor.computeLuminance();
    
    // Use white text for dark backgrounds, dark text for light backgrounds
    return luminance > 0.5 ? const Color(0xFF2C2C2C) : Colors.white;
  }

  /// Calculates appropriate font size based on avatar size
  double _getFontSize() {
    if (size <= 32) return size * 0.4;
    if (size <= 56) return size * 0.35;
    if (size <= 80) return size * 0.32;
    return size * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(name);
    final effectiveBackgroundColor = backgroundColor ?? 
        (useColorFromName ? _generateColorFromName(name) : Theme.of(context).colorScheme.primary);
    final effectiveTextColor = textColor ?? _getContrastingTextColor(effectiveBackgroundColor);
    final fontSize = _getFontSize();

    return Container(
      width: size,
      height: size,
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: effectiveBackgroundColor.withOpacity(0.3),
            blurRadius: size * 0.1,
            offset: Offset(0, size * 0.05),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: textStyle ?? TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: effectiveTextColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// A specialized avatar widget that tries to load a network image first,
/// then falls back to letter avatar if the image fails to load
class NetworkLetterAvatar extends StatefulWidget {
  final String name;
  final String? imageUrl;
  final double size;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final bool useColorFromName;
  final String? fallbackText;
  final BoxFit imageFit;

  const NetworkLetterAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 40,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.useColorFromName = true,
    this.fallbackText,
    this.imageFit = BoxFit.cover,
  });

  @override
  State<NetworkLetterAvatar> createState() => _NetworkLetterAvatarState();
}

class _NetworkLetterAvatarState extends State<NetworkLetterAvatar> {
  bool _hasImageError = false;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    // If no image URL provided or has error, show letter avatar
    if (widget.imageUrl == null || 
        widget.imageUrl!.isEmpty || 
        _hasImageError) {
      return LetterAvatar(
        name: widget.name,
        size: widget.size,
        textStyle: widget.textStyle,
        backgroundColor: widget.backgroundColor,
        textColor: widget.textColor,
        useColorFromName: widget.useColorFromName,
        fallbackText: widget.fallbackText,
      );
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          // Letter avatar as background while loading
          LetterAvatar(
            name: widget.name,
            size: widget.size,
            textStyle: widget.textStyle,
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
            useColorFromName: widget.useColorFromName,
            fallbackText: widget.fallbackText,
          ),
          // Network image overlay
          ClipOval(
            child: Image.network(
              widget.imageUrl!,
              width: widget.size,
              height: widget.size,
              fit: widget.imageFit,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  // Image loaded successfully
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  });
                  return child;
                }
                // Show loading (letter avatar remains visible in background)
                return const SizedBox.shrink();
              },
              errorBuilder: (context, error, stackTrace) {
                // Image failed to load, show letter avatar
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _hasImageError = true;
                      _isLoading = false;
                    });
                  }
                });
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}