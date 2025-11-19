import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttld/helppers/ny_color.dart';
import 'package:ttld/helppers/ny_text_style.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomPickDateTimeGrok extends StatefulWidget {
  const CustomPickDateTimeGrok({
    super.key,
    this.labelText,
    this.hintText,
    this.helperText,
    this.onChanged,
    this.selectedDate,
    this.validator,
    this.initialValue,
    this.enabled = true,
    this.style,
    this.prefixIcon,
  });

  final String? labelText;
  final String? hintText;
  final String? helperText;
  final ValueChanged<String?>? onChanged;
  final DateTime? selectedDate;
  final String? Function(DateTime?)? validator;
  final dynamic initialValue;
  final bool enabled;
  final ModernDatePickerStyle? style;
  final Widget? prefixIcon;

  @override
  State<CustomPickDateTimeGrok> createState() => _CustomPickDateTimeGrokState();
}

class _CustomPickDateTimeGrokState extends State<CustomPickDateTimeGrok> {
  DateTime? _selectedDate;
  String? _errorText;
  final FocusNode _focusNode = FocusNode();
  bool _hasBeenFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedDate =
        _parseInitialValue(widget.initialValue) ?? widget.selectedDate;
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
        _errorText = widget.validator!(_selectedDate);
      });
    }
  }

  DateTime? _parseInitialValue(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return _validateDateRange(value);
    if (value is String) {
      try {
        final parsedIso = DateTime.parse(value);
        return _validateDateRange(parsedIso);
      } catch (e) {
        try {
          final ymdFormat = DateFormat('yyyy-MM-dd');
          final parsedYmd = ymdFormat.parse(value);
          return _validateDateRange(parsedYmd);
        } catch (e) {
          try {
            final dmyFormat = DateFormat('dd-MM-yyyy');
            final parsedDmy = dmyFormat.parse(value);
            return _validateDateRange(parsedDmy);
          } catch (e) {
            return null;
          }
        }
      }
    }
    return null;
  }

  DateTime? _validateDateRange(DateTime parsed) {
    final firstDate = DateTime(1900);
    final lastDate = DateTime(2100);
    if (parsed.isBefore(firstDate) || parsed.isAfter(lastDate)) return null;
    return parsed;
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate) {
      final normalizedDate =
          DateTime.utc(picked.year, picked.month, picked.day);
      setState(() {
        _selectedDate = normalizedDate;
      });
      final isoDate = normalizedDate.toIso8601String();
      print("Sending ISO 8601: '$isoDate'");
      widget.onChanged?.call(isoDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyles =
        ThemeProvider.themeOf(context).data.extension<ColorStyles>();
    final effectiveStyle =
        widget.style ?? ModernDatePickerStyle.defaultStyle(context);

    // Theme-aware colors matching GenericPicker
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

    return Padding(
      padding: effectiveStyle.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Focus(
            focusNode: _focusNode,
            child: InkWell(
              onTap: widget.enabled ? () => _selectYear(context) : null,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: effectiveStyle.filled
                      ? (effectiveStyle.fillColor?.toColor(context) ??
                          surfaceColor.withOpacity(0.05))
                      : Colors.transparent,
                  border: Border.all(
                    color: getBorderColor(),
                    width: _focusNode.hasFocus ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: effectiveStyle.contentPadding,
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      widget.prefixIcon!,
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.labelText != null &&
                              widget.labelText!.isNotEmpty)
                            Text(
                              widget.labelText!,
                              style: effectiveStyle.labelStyle
                                      ?.toTextStyle(context) ??
                                  theme.textTheme.bodySmall?.copyWith(
                                    color: _focusNode.hasFocus
                                        ? primaryColor
                                        : contentColor.withOpacity(0.7),
                                  ),
                            ),
                          if (widget.labelText != null &&
                              widget.labelText!.isNotEmpty)
                            const SizedBox(height: 4),
                          Text(
                            _selectedDate != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate!.toLocal())
                                : widget.hintText ?? 'Select Date',
                            style: effectiveStyle.textStyle
                                    ?.toTextStyle(context) ??
                                theme.textTheme.bodyLarge?.copyWith(
                                  color: _selectedDate != null
                                      ? contentColor
                                      : contentColor.withOpacity(0.5),
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
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Text(
                _errorText!,
                style: theme.textTheme.bodySmall?.copyWith(color: errorColor),
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

  String? validate() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_selectedDate);
      });
      return _errorText;
    }
    return null;
  }
}

/// Style configuration for CustomPickDateTimeGrok, consistent with ModernPicker styling
class ModernDatePickerStyle {
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final bool filled;
  final NyColor? fillColor;
  final NyTextStyle? textStyle;
  final NyTextStyle? labelStyle;
  final NyTextStyle? hintStyle;

  const ModernDatePickerStyle({
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.filled = true,
    this.fillColor,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
  });

  /// Default style that follows the project's design system
  factory ModernDatePickerStyle.defaultStyle(BuildContext context) {
    return const ModernDatePickerStyle();
  }

  /// Compact style for forms with many fields
  factory ModernDatePickerStyle.compact() {
    return const ModernDatePickerStyle(
      margin: EdgeInsets.symmetric(vertical: 4),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  /// Style for prominent fields
  factory ModernDatePickerStyle.prominent() {
    return const ModernDatePickerStyle(
      margin: EdgeInsets.symmetric(vertical: 12),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  ModernDatePickerStyle copyWith({
    EdgeInsets? margin,
    EdgeInsets? contentPadding,
    bool? filled,
    NyColor? fillColor,
    NyTextStyle? textStyle,
    NyTextStyle? labelStyle,
    NyTextStyle? hintStyle,
  }) {
    return ModernDatePickerStyle(
      margin: margin ?? this.margin,
      contentPadding: contentPadding ?? this.contentPadding,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
    );
  }
}
