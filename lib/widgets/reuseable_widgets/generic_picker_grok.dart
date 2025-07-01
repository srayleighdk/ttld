import 'package:flutter/material.dart';
import 'package:ttld/helppers/ny_color.dart';
import 'package:ttld/helppers/ny_text_style.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

/// A generic picker item that can be used with ModernPicker
class GenericPickerItem {
  final dynamic id;
  final String displayName;

  const GenericPickerItem({
    required this.id,
    required this.displayName,
  });
}

/// Modern, theme-aware picker widget that follows the project's design system.
/// Designed to be consistent with ModernTextField for a unified form experience.
class ModernPicker<T extends GenericPickerItem> extends StatefulWidget {
  // Core properties
  final String? label;
  final String? hint;
  final String? helperText;
  final dynamic initialValue;
  final List<T> items;
  final void Function(T?) onChanged;
  
  // Validation
  final String? Function(T?)? validator;
  
  // State indicators
  final bool isLoading;
  final bool enabled;
  
  // Styling
  final ModernPickerStyle? style;
  final Widget? prefixIcon;
  
  const ModernPicker({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.initialValue,
    required this.items,
    required this.onChanged,
    this.validator,
    this.isLoading = false,
    this.enabled = true,
    this.style,
    this.prefixIcon,
  });

  @override
  State<ModernPicker<T>> createState() => _ModernPickerState<T>();
}

class _ModernPickerState<T extends GenericPickerItem> extends State<ModernPicker<T>> {
  T? _selectedItem;
  String? _errorText;
  final FocusNode _focusNode = FocusNode();
  bool _hasBeenFocused = false;

  @override
  void initState() {
    super.initState();
    _updateSelectedItem();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ModernPicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger update if items or initialValue changes
    if (oldWidget.items != widget.items ||
        oldWidget.initialValue != widget.initialValue) {
      _updateSelectedItem();
    }
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
        _errorText = widget.validator!(_selectedItem);
      });
    }
  }

  void _updateSelectedItem() {
    // If items is empty, reset selectedItem
    if (widget.items.isEmpty) {
      _selectedItem = null;
      return;
    }

    // Check if the current selectedItem is still valid in the new items list
    if (_selectedItem != null &&
        !widget.items.any((item) => item.id == _selectedItem!.id)) {
      _selectedItem = null;
    }

    // Apply initialValue if provided and valid
    if (widget.initialValue != null) {
      try {
        _selectedItem = widget.items.firstWhere(
          (item) => item.id == widget.initialValue,
          orElse: () => throw Exception('Item not found'),
        );
      } catch (e) {
        _selectedItem = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyles = ThemeProvider.themeOf(context).data.extension<ColorStyles>();
    final effectiveStyle = widget.style ?? ModernPickerStyle.defaultStyle(context);
    
    // Theme-aware colors
    final primaryColor = colorStyles?.primaryAccent ?? theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;
    final surfaceColor = colorStyles?.surfaceBackground ?? theme.colorScheme.surface;
    final contentColor = colorStyles?.content ?? theme.colorScheme.onSurface;
    
    Color getBorderColor() {
      if (_errorText != null) return errorColor;
      if (_focusNode.hasFocus) return primaryColor;
      return contentColor.withOpacity(0.3);
    }

    return Padding(
      padding: effectiveStyle.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormField<T>(
            validator: widget.validator,
            initialValue: _selectedItem,
            builder: (FormFieldState<T> state) {
              return DropdownMenu<T>(
                key: ValueKey('${widget.items.length}_${_selectedItem?.hashCode}'),
                focusNode: _focusNode,
                label: widget.label != null ? Text(widget.label!) : null,
                initialSelection: _selectedItem,
                enabled: widget.enabled,
                onSelected: (T? value) {
                  setState(() {
                    _selectedItem = value;
                    _errorText = null;
                  });
                  widget.onChanged(value);
                  state.didChange(value);
                  _validateSelection();
                },
                dropdownMenuEntries: widget.items.map((T item) {
                  return DropdownMenuEntry<T>(
                    value: item,
                    label: item.displayName,
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
                    theme.textTheme.bodyLarge,
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStateProperty.all(
                    surfaceColor,
                  ),
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
                        color: _focusNode.hasFocus ? primaryColor : contentColor.withOpacity(0.7),
                      ),
                  hintStyle: effectiveStyle.hintStyle?.toTextStyle(context) ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: contentColor.withOpacity(0.5),
                      ),
                  border: effectiveStyle.border ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: contentColor.withOpacity(0.3)),
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
                    borderSide: BorderSide(color: contentColor.withOpacity(0.1)),
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

/// Style configuration for ModernPicker, designed to be consistent with ModernTextFieldStyle
class ModernPickerStyle {
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final bool filled;
  final NyColor? fillColor;
  final NyTextStyle? textStyle;
  final NyTextStyle? labelStyle;
  final NyTextStyle? hintStyle;
  final InputBorder? border;
  final double menuHeight;

  const ModernPickerStyle({
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
  factory ModernPickerStyle.defaultStyle(BuildContext context) {
    return const ModernPickerStyle();
  }

  /// Compact style for forms with many fields
  factory ModernPickerStyle.compact() {
    return const ModernPickerStyle(
      margin: EdgeInsets.symmetric(vertical: 4),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      menuHeight: 250,
    );
  }

  /// Style for prominent fields
  factory ModernPickerStyle.prominent() {
    return const ModernPickerStyle(
      margin: EdgeInsets.symmetric(vertical: 12),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      menuHeight: 350,
    );
  }

  ModernPickerStyle copyWith({
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
    return ModernPickerStyle(
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
/// @deprecated Use ModernPicker instead
class GenericPicker<T extends GenericPickerItem> extends StatefulWidget {
  final dynamic initialValue;
  final void Function(T?) onChanged;
  final String? hintText;
  final bool isLoading;
  final String label;
  final List<T> items;

  const GenericPicker({
    this.initialValue,
    required this.onChanged,
    required this.label,
    required this.items,
    this.hintText,
    this.isLoading = false,
    super.key,
  });

  @override
  _GenericPickerState<T> createState() => _GenericPickerState<T>();
}

class _GenericPickerState<T extends GenericPickerItem>
    extends State<GenericPicker<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _updateSelectedItem();
  }

  @override
  void didUpdateWidget(GenericPicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger update if items or initialValue changes
    if (oldWidget.items != widget.items ||
        oldWidget.initialValue != widget.initialValue) {
      _updateSelectedItem();
    }
  }

  void _updateSelectedItem() {
    // If items is empty or null, reset selectedItem
    if (widget.items.isEmpty) {
      _selectedItem = null;
      return;
    }

    // Check if the current selectedItem is still valid in the new items list
    if (_selectedItem != null &&
        !widget.items.any((item) => item.id == _selectedItem!.id)) {
      _selectedItem = null;
    }

    // Apply initialValue if provided and valid
    if (widget.initialValue != null) {
      try {
        _selectedItem = widget.items.firstWhere(
          (item) => item.id == widget.initialValue,
          orElse: () => throw Exception('Item not found'),
        );
      } catch (e) {
        _selectedItem = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the new ModernPicker for consistent styling
    return ModernPicker<T>(
      label: widget.label,
      hint: widget.hintText,
      initialValue: widget.initialValue,
      items: widget.items,
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
        });
        widget.onChanged(value);
      },
      isLoading: widget.isLoading,
    );
  }
}