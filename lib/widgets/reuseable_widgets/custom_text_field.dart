import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttld/helppers/ny_color.dart';
import 'package:ttld/helppers/ny_text_style.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? helperText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final dynamic validator;
  final void Function(String)? onChanged;
  final DecoratorTextField? decoration;
  final bool validateOnBlur;
  final bool autoValidate;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool enabled;
  final ModernTextFieldStyle? style;

  const CustomTextField({
      super.key,
      this.labelText = '',
      required this.hintText,
      this.helperText,
      this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.decoration,
      this.validateOnBlur = true,
      this.autoValidate = false,
      this.focusNode,
      this.maxLines = 1,
      this.minLines,
      this.maxLength,
      this.expands = false,
      this.inputFormatters,
      this.readOnly = false,
      this.enabled = true,
      this.style,
  });

  factory CustomTextField.email({
    TextEditingController? controller,
    dynamic validator,
    void Function(String)? onChanged,
  }) {
    return CustomTextField(
      labelText: 'Email',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
      controller: controller,
      validator: validator,
      onChanged: onChanged,
    );
  }

  factory CustomTextField.password({
    TextEditingController? controller,
    dynamic validator,
    void Function(String)? onChanged,
  }) {
    return CustomTextField(
      labelText: 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      prefixIcon: const Icon(Icons.lock),
      controller: controller,
      validator: validator,
      onChanged: onChanged,
    );
  }

  factory CustomTextField.numberGrok({
    TextEditingController? controller,
    dynamic validator,
    void Function(String)? onChanged,
    String hintText = 'Enter a number',
    String labelText = 'Number',
  }) {
    return CustomTextField(
      labelText: labelText,
      hintText: hintText,
      keyboardType: TextInputType.number,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  factory CustomTextField.addressDetail({
    Key? key,
    required TextEditingController controller,
    String? tinh,
    String? huyen,
    String? xa,
    String labelText = "Địa chỉ chi tiết",
    dynamic validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    String hintText = _buildAddressHint(xa, huyen, tinh);
    return CustomTextField(
      key: key,
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      validator: validator,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
    );
  }

  static String _buildAddressHint(String? xa, String? huyen, String? tinh) {
    String address = "";
    if (xa != null && xa.isNotEmpty) {
      address += "Xã $xa";
    }
    if (huyen != null && huyen.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += "Huyện $huyen";
    }
    if (tinh != null && tinh.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += "Tỉnh $tinh";
    }
    return address.isNotEmpty ? address : "Địa chỉ chi tiết";
  }

// Add this method to handle predefined validators
  static String? handleValidation(String? value, dynamic validator) {
    if (validator == null) return null;

    if (validator is String) {
      switch (validator) {
        case 'not_empty':
          return value == null || value.trim().isEmpty
              ? 'This field is required'
              : null;
        case 'email':
          if (value == null || value.trim().isEmpty) {
            return 'Email is required';
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          return !emailRegex.hasMatch(value)
              ? 'Please enter a valid email'
              : null;
        case 'phone':
          if (value == null || value.trim().isEmpty) {
            return 'Phone number is required';
          }
          final phoneRegex = RegExp(r'^\d{10}$');
          return !phoneRegex.hasMatch(value)
              ? 'Please enter a valid 10-digit phone number'
              : null;
        default:
          return null;
      }
    }

    // If validator is a function, use it directly
    if (validator is String? Function(String?)) {
      return validator(value);
    }

    return null;
  }

  // Add new factory constructor for numbers
  factory CustomTextField.number({
    Key? key,
    String labelText = '',
    String hintText = '',
    TextEditingController? controller,
    bool allowDecimals = true,
    num? min,
    num? max,
    dynamic validator,
    void Function(String)? onChanged,
  }) {
    final numberController = controller ?? TextEditingController();

    return CustomTextField(
      key: key,
      labelText: labelText,
      hintText: hintText,
      controller: numberController,
      keyboardType: allowDecimals
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      validator: (String? value) {
        if (validator != null) {
          final validatorResult =
              CustomTextField.handleValidation(value, validator);
          if (validatorResult != null) return validatorResult;
        }

        if (value == null || value.isEmpty) {
          return 'This field is required';
        }

        // Try parsing the number
        try {
          final number = allowDecimals ? double.parse(value) : int.parse(value);

          // Check min value
          if (min != null && number < min) {
            return 'Value must be greater than or equal to $min';
          }

          // Check max value
          if (max != null && number > max) {
            return 'Value must be less than or equal to $max';
          }
        } catch (e) {
          return allowDecimals
              ? 'Please enter a valid number'
              : 'Please enter a valid integer';
        }

        return null;
      },
      onChanged: (value) {
        // Remove any non-numeric characters except decimal point if allowed
        final newValue = value.replaceAll(
            allowDecimals ? RegExp(r'[^0-9.]') : RegExp(r'[^0-9]'), '');

        // Ensure only one decimal point
        if (allowDecimals && newValue.split('.').length > 2) {
          numberController.text = newValue.replaceFirst(RegExp(r'\..*\.'), '.');
          numberController.selection = TextSelection.fromPosition(
            TextPosition(offset: numberController.text.length),
          );
        } else {
          numberController.text = newValue;
          numberController.selection = TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          );
        }

        if (onChanged != null) {
          onChanged(newValue);
        }
      },
    );
  }

  // Add new factory constructor for text area
  factory CustomTextField.textArea({
    Key? key,
    String labelText = '',
    String hintText = '',
    TextEditingController? controller,
    int? minLines = 3,
    int? maxLines = 5,
    int? maxLength,
    dynamic validator,
    void Function(String)? onChanged,
    bool autoValidate = false,
  }) {
    return CustomTextField(
      key: key,
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      autoValidate: autoValidate,
      decoration: DecoratorTextField(
        decoration: (data, decoration) {
          return decoration.copyWith(
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.all(12),
          );
        },
      ),
    );
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isValid = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Validate when focus is lost
      setState(() {
        if (widget.validator != null) {
          _errorText = CustomTextField.handleValidation(
              _controller.text, widget.validator);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyles = ThemeProvider.themeOf(context).data.extension<ColorStyles>();
    final effectiveStyle = widget.style ?? ModernTextFieldStyle.defaultStyle(context);
    
    // Theme-aware colors matching GenericPicker
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
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            expands: widget.expands,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            validator: (value) {
              final error = CustomTextField.handleValidation(value, widget.validator);
              setState(() {
                _errorText = error;
                _isValid = error == null;
              });
              return null; // Return null to prevent built-in error display
            },
            onChanged: (value) {
              if (widget.autoValidate) {
                setState(() {
                  _errorText = CustomTextField.handleValidation(value, widget.validator);
                  _isValid = _errorText == null;
                });
              } else {
                setState(() {
                  _errorText = null;
                });
              }
              widget.onChanged?.call(value);
            },
            style: effectiveStyle.textStyle?.toTextStyle(context) ?? theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: widget.labelText.isNotEmpty ? widget.labelText : null,
              hintText: widget.hintText,
              alignLabelWithHint: true,
              filled: effectiveStyle.filled,
              fillColor: effectiveStyle.fillColor?.toColor(context) ?? 
                        surfaceColor.withOpacity(0.05),
              contentPadding: effectiveStyle.contentPadding,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              
              // Modern styling matching GenericPicker
              labelStyle: effectiveStyle.labelStyle?.toTextStyle(context) ??
                         theme.textTheme.bodyMedium?.copyWith(
                           color: _focusNode.hasFocus ? primaryColor : contentColor.withOpacity(0.7),
                         ),
              hintStyle: effectiveStyle.hintStyle?.toTextStyle(context) ??
                        theme.textTheme.bodyMedium?.copyWith(
                          color: contentColor.withOpacity(0.5),
                        ),
              floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
                color: _errorText != null ? errorColor : primaryColor,
              ),
              
              // Consistent border styling with 8px radius
              border: effectiveStyle.border ?? OutlineInputBorder(
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

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// Style configuration for CustomTextField, consistent with ModernPicker styling
class ModernTextFieldStyle {
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final bool filled;
  final NyColor? fillColor;
  final NyTextStyle? textStyle;
  final NyTextStyle? labelStyle;
  final NyTextStyle? hintStyle;
  final InputBorder? border;

  const ModernTextFieldStyle({
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.filled = true,
    this.fillColor,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.border,
  });

  /// Default style that follows the project's design system
  factory ModernTextFieldStyle.defaultStyle(BuildContext context) {
    return const ModernTextFieldStyle();
  }

  /// Compact style for forms with many fields
  factory ModernTextFieldStyle.compact() {
    return const ModernTextFieldStyle(
      margin: EdgeInsets.symmetric(vertical: 4),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  /// Style for prominent fields
  factory ModernTextFieldStyle.prominent() {
    return const ModernTextFieldStyle(
      margin: EdgeInsets.symmetric(vertical: 12),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  ModernTextFieldStyle copyWith({
    EdgeInsets? margin,
    EdgeInsets? contentPadding,
    bool? filled,
    NyColor? fillColor,
    NyTextStyle? textStyle,
    NyTextStyle? labelStyle,
    NyTextStyle? hintStyle,
    InputBorder? border,
  }) {
    return ModernTextFieldStyle(
      margin: margin ?? this.margin,
      contentPadding: contentPadding ?? this.contentPadding,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      border: border ?? this.border,
    );
  }
}

class DecoratorTextField {
  final InputDecoration Function(dynamic data, InputDecoration inputDecoration)?
      decoration;
  final InputDecoration Function(dynamic data, InputDecoration inputDecoration)?
      successDecoration;
  final InputDecoration Function(dynamic data, InputDecoration inputDecoration)?
      errorDecoration;

  DecoratorTextField({
    this.decoration,
    this.successDecoration,
    this.errorDecoration,
  });
}
