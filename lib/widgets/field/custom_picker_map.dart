import 'package:flutter/material.dart';
import 'package:ttld/helppers/ny_color.dart';
import 'package:ttld/helppers/ny_text_style.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

/// Modern, theme-aware map picker widget that follows the project's design system.
/// Designed to be consistent with ModernTextField and ModernPicker for a unified form experience.
class ModernPickerMap<K> extends StatefulWidget {
  // Core properties
  final String? label;
  final String? hint;
  final String? helperText;
  final Map<K, String> items;
  final K? selectedItem;
  final ValueChanged<K?> onChanged;

  // Validation
  final String? Function(K?)? validator;

  // State indicators
  final bool isLoading;
  final bool enabled;

  // Styling
  final ModernPickerMapStyle? style;
  final Widget? prefixIcon;

  // Display customization
  final String Function(String?)? displayItemBuilder;

  const ModernPickerMap({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.validator,
    this.isLoading = false,
    this.enabled = true,
    this.style,
    this.prefixIcon,
    this.displayItemBuilder,
  });

  @override
  State<ModernPickerMap<K>> createState() => _ModernPickerMapState<K>();
}

class _ModernPickerMapState<K> extends State<ModernPickerMap<K>> {
  String? _errorText;
  final FocusNode _focusNode = FocusNode();
  bool _hasBeenFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _hasBeenFocused) {
      _validateSelection();
    }
    if (_focusNode.hasFocus) {
      _hasBeenFocused = true;
    }
    setState(() {});
  }

  void _validateSelection() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(widget.selectedItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyles =
        ThemeProvider.themeOf(context).data.extension<ColorStyles>();
    final effectiveStyle =
        widget.style ?? ModernPickerMapStyle.defaultStyle(context);

    // Theme-aware colors
    final primaryColor =
        colorStyles?.primaryAccent ?? theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;
    final surfaceColor =
        colorStyles?.surfaceBackground ?? theme.colorScheme.surface;
    final contentColor = colorStyles?.content ?? theme.colorScheme.onSurface;

    Color getBorderColor() {
      if (_errorText != null) return errorColor;
      if (_focusNode.hasFocus) return primaryColor;
      return contentColor.withOpacity(0.3);
    }

    Color getLabelColor() {
      if (_errorText != null) return errorColor;
      if (_focusNode.hasFocus) return primaryColor;
      return contentColor.withOpacity(0.7);
    }

    return Padding(
      padding: effectiveStyle.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormField<K>(
            validator: widget.validator,
            initialValue: widget.selectedItem,
            builder: (FormFieldState<K> state) {
              return DropdownMenu<K>(
                key: ValueKey(
                    '${widget.items.length}_${widget.selectedItem?.hashCode}'),
                focusNode: _focusNode,
                label: widget.label != null ? Text(widget.label!) : null,
                initialSelection: widget.selectedItem,
                enabled: widget.enabled,
                onSelected: (K? value) {
                  setState(() {
                    _errorText = null;
                  });
                  widget.onChanged(value);
                  state.didChange(value);
                  _validateSelection();
                },
                dropdownMenuEntries: widget.items.entries.map((entry) {
                  return DropdownMenuEntry<K>(
                    value: entry.key,
                    label: widget.displayItemBuilder != null
                        ? widget.displayItemBuilder!(entry.value)
                        : entry.value,
                    style: MenuItemButton.styleFrom(
                      foregroundColor: contentColor,
                      backgroundColor: surfaceColor,
                    ),
                  );
                }).toList(),
                hintText: widget.hint ?? 'Select an option',
                expandedInsets: EdgeInsets.zero,
                menuHeight: effectiveStyle.menuHeight,
                leadingIcon: widget.prefixIcon,
                trailingIcon: widget.isLoading
                    ? SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            primaryColor.withOpacity(0.7),
                          ),
                        ),
                      )
                    : null,
                textStyle: effectiveStyle.textStyle?.toTextStyle(context) ??
                    theme.textTheme.bodyLarge?.copyWith(color: contentColor),
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStateProperty.all(surfaceColor),
                  elevation: MaterialStateProperty.all(4),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: effectiveStyle.filled,
                  fillColor: effectiveStyle.fillColor?.toColor(context) ??
                      surfaceColor.withOpacity(0.05),
                  contentPadding: effectiveStyle.contentPadding,
                  labelStyle: effectiveStyle.labelStyle?.toTextStyle(context) ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: getLabelColor(),
                      ),
                  hintStyle: effectiveStyle.hintStyle?.toTextStyle(context) ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: contentColor.withOpacity(0.5),
                      ),
                  border: effectiveStyle.border ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: contentColor.withOpacity(0.3)),
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: getBorderColor()),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: getBorderColor(), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: errorColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: errorColor, width: 2),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: contentColor.withOpacity(0.1)),
                  ),
                ),
              );
            },
          ),
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Text(
                _errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: errorColor,
                ),
              ),
            ),
          if (widget.helperText != null && _errorText == null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Text(
                widget.helperText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorStyles?.content.withOpacity(0.6) ??
                      theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Style configuration for ModernPickerMap, designed to be consistent with ModernTextFieldStyle
class ModernPickerMapStyle {
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final bool filled;
  final NyColor? fillColor;
  final NyTextStyle? textStyle;
  final NyTextStyle? labelStyle;
  final NyTextStyle? hintStyle;
  final InputBorder? border;
  final double menuHeight;

  const ModernPickerMapStyle({
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.filled = true,
    this.fillColor,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.border,
    this.menuHeight = 300,
  });

  /// Default style that follows the project's design system
  factory ModernPickerMapStyle.defaultStyle(BuildContext context) {
    return const ModernPickerMapStyle();
  }

  /// Compact style for forms with many fields
  factory ModernPickerMapStyle.compact() {
    return const ModernPickerMapStyle(
      margin: EdgeInsets.symmetric(vertical: 4),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      menuHeight: 250,
    );
  }

  /// Style for prominent fields
  factory ModernPickerMapStyle.prominent() {
    return const ModernPickerMapStyle(
      margin: EdgeInsets.symmetric(vertical: 12),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      menuHeight: 350,
    );
  }

  ModernPickerMapStyle copyWith({
    EdgeInsets? margin,
    EdgeInsets? contentPadding,
    bool? filled,
    NyColor? fillColor,
    NyTextStyle? textStyle,
    NyTextStyle? labelStyle,
    NyTextStyle? hintStyle,
    InputBorder? border,
    double? menuHeight,
  }) {
    return ModernPickerMapStyle(
      margin: margin ?? this.margin,
      contentPadding: contentPadding ?? this.contentPadding,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      border: border ?? this.border,
      menuHeight: menuHeight ?? this.menuHeight,
    );
  }
}

/// Legacy class for backward compatibility
/// @deprecated Use ModernPickerMap instead
class CustomPickerMap<K> extends StatelessWidget {
  final Map<K, String> items;
  final K? selectedItem;
  final ValueChanged<K?> onChanged;
  final String hint;
  final Color? backgroundColor;
  final String Function(String?)? displayItemBuilder;
  final Widget? label;
  final String? Function(K?)? validator;

  const CustomPickerMap({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hint = 'Select an option',
    this.backgroundColor,
    this.displayItemBuilder,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Use the new ModernPickerMap for consistent styling
    return ModernPickerMap<K>(
      label:
          label != null ? (label is Text ? (label as Text).data : null) : null,
      hint: hint,
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      displayItemBuilder: displayItemBuilder,
      prefixIcon: label is! Text ? label : null,
      validator: validator,
    );
  }
}
