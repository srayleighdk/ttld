import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttld/helppers/form_validation.dart';
import 'package:ttld/helppers/ny_color.dart';
import 'package:ttld/helppers/ny_text_style.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

/// Modern, theme-aware text field widget that follows the project's design system.
///
/// Features:
/// - Consistent theming with project color system
/// - Built-in validation support
/// - Multiple field types (text, email, password, number, etc.)
/// - Clean, maintainable code structure
/// - Accessibility support
/// - Responsive design
class ModernTextField extends StatefulWidget {
  // Core properties
  final String? label;
  final String? hint;
  final String? helperText;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // Input configuration
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;

  // Validation
  final List<FormValidator>? validators;
  final bool validateOnChange;
  final bool validateOnFocusLoss;
  final String? Function(String?)? customValidator;

  // Styling
  final ModernTextFieldStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;

  // Text constraints
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;

  // Input formatting
  final List<TextInputFormatter>? inputFormatters;

  // Callbacks
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;

  // Field type differentiation
  final bool isPassword;
  final bool isSearch;
  final VoidCallback? onClear;

  const ModernTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.validators,
    this.validateOnChange = false,
    this.validateOnFocusLoss = true,
    this.customValidator,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.expands = false,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.onEditingComplete,
    this.isPassword = false,
    this.isSearch = false,
    this.onClear,
  });

  // Factory constructors for common field types

  /// Creates an email input field with built-in validation
  factory ModernTextField.email({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool required = false,
    bool readOnly = false,
    ModernTextFieldStyle? style,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return ModernTextField(
      key: key,
      label: label ?? 'Email',
      hint: hint ?? 'Enter your email address',
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      enableSuggestions: false,
      prefixIcon: const Icon(Icons.email_outlined),
      validators: [
        if (required) FormValidator.rule('required'),
        FormValidator.email(),
      ],
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  /// Creates a password input field with visibility toggle
  factory ModernTextField.password({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool required = false,
    int strengthLevel = 1,
    ModernTextFieldStyle? style,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return ModernTextField(
      key: key,
      label: label ?? 'Password',
      hint: hint ?? 'Enter your password',
      controller: controller,
      focusNode: focusNode,
      isPassword: true,
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      prefixIcon: const Icon(Icons.lock_outlined),
      validators: [
        if (required) FormValidator.rule('required'),
        FormValidator.password(strength: strengthLevel),
      ],
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  /// Creates a phone number input field
  factory ModernTextField.phone({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool required = false,
    ModernTextFieldStyle? style,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return ModernTextField(
      key: key,
      label: label ?? 'Phone Number',
      hint: hint ?? 'Enter your phone number',
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.phone_outlined),
      validators: [
        if (required) FormValidator.rule('required'),
        FormValidator.phoneNumber(),
      ],
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  /// Creates a number input field with optional decimal support
  factory ModernTextField.number({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool required = false,
    bool allowDecimals = false,
    num? min,
    num? max,
    ModernTextFieldStyle? style,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return ModernTextField(
      key: key,
      label: label ?? 'Number',
      hint: hint ?? 'Enter a number',
      controller: controller,
      focusNode: focusNode,
      keyboardType: allowDecimals
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        if (allowDecimals)
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        else
          FilteringTextInputFormatter.digitsOnly,
      ],
      validators: [
        if (required) FormValidator.rule('required'),
        if (min != null) FormValidator.minValue(min.toInt()),
        if (max != null) FormValidator.maxValue(max.toInt()),
      ],
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  /// Creates a multi-line text area
  factory ModernTextField.textArea({
    Key? key,
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool required = false,
    int minLines = 3,
    int maxLines = 6,
    int? maxLength,
    ModernTextFieldStyle? style,
    void Function(String)? onChanged,
  }) {
    return ModernTextField(
      key: key,
      label: label,
      hint: hint,
      helperText: helperText,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      validators: required ? [FormValidator.rule('required')] : null,
      style: style?.copyWith(
        contentPadding: const EdgeInsets.all(16),
      ) ??
          const ModernTextFieldStyle(
            contentPadding: EdgeInsets.all(16),
          ),
      onChanged: onChanged,
    );
  }

  /// Creates a search input field
  factory ModernTextField.search({
    Key? key,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    ModernTextFieldStyle? style,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    VoidCallback? onClear,
  }) {
    return ModernTextField(
      key: key,
      hint: hint ?? 'Search...',
      controller: controller,
      focusNode: focusNode,
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onClear: onClear,
      isSearch: true,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search_outlined),
    );
  }

  @override
  State<ModernTextField> createState() => _ModernTextFieldState();
}

class _ModernTextFieldState extends State<ModernTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _errorText;
  bool _hasBeenFocused = false;
  late bool _obscureText;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _obscureText = widget.obscureText;

    if (widget.isSearch) {
      _hasText = _controller.text.isNotEmpty;
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.isSearch) {
      _controller.removeListener(_onTextChanged);
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _hasBeenFocused && widget.validateOnFocusLoss) {
      _validateInput(_controller.text);
    }
    if (_focusNode.hasFocus) {
      _hasBeenFocused = true;
    }
    setState(() {});
  }

  void _validateInput(String value) {
    String? error;

    // Custom validator first
    if (widget.customValidator != null) {
      error = widget.customValidator!(value);
    }

    // Then built-in validators
    if (error == null && widget.validators != null) {
      for (final validator in widget.validators!) {
        error = _executeValidator(validator, value);
        if (error != null) break;
      }
    }

    setState(() {
      _errorText = error;
    });
  }

  String? _executeValidator(FormValidator validator, String value) {
    // This is a simplified version - you might want to integrate
    // with the full FormValidator system from the project
    if (validator.rules == 'required' && value.trim().isEmpty) {
      return validator.message ?? 'This field is required';
    }
    if (validator.rules == 'email') {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return validator.message ?? 'Please enter a valid email';
      }
    }
    // Add more validation rules as needed
    return null;
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _clearText() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyles = ThemeProvider.themeOf(context).data.extension<ColorStyles>();
    final effectiveStyle = widget.style ?? ModernTextFieldStyle.defaultStyle(context);

    return Padding(
      padding: effectiveStyle.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: _obscureText,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            autocorrect: widget.autocorrect,
            enableSuggestions: widget.enableSuggestions,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            expands: widget.expands,
            inputFormatters: widget.inputFormatters,
            style: effectiveStyle.textStyle?.toTextStyle(context) ??
                theme.textTheme.bodyLarge,
            decoration: _buildInputDecoration(context, effectiveStyle, colorStyles),
            onChanged: (value) {
              if (widget.validateOnChange) {
                _validateInput(value);
              }
              widget.onChanged?.call(value);
            },
            onTap: widget.onTap,
            onFieldSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete,
            validator: widget.validateOnChange
                ? null
                : (value) {
                    _validateInput(value ?? '');
                    return _errorText;
                  },
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

  InputDecoration _buildInputDecoration(
    BuildContext context,
    ModernTextFieldStyle style,
    ColorStyles? colorStyles,
  ) {
    final theme = Theme.of(context);
    final hasError = _errorText != null;
    final isFocused = _focusNode.hasFocus;

    // Theme-aware colors
    final primaryColor = colorStyles?.primaryAccent ?? theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;
    final surfaceColor = colorStyles?.surfaceBackground ?? theme.colorScheme.surface;
    final contentColor = colorStyles?.content ?? theme.colorScheme.onSurface;

    Color getBorderColor() {
      if (hasError) return errorColor;
      if (isFocused) return primaryColor;
      return contentColor.withOpacity(0.3);
    }

    Color getLabelColor() {
      if (hasError) return errorColor;
      if (isFocused) return primaryColor;
      return contentColor.withOpacity(0.7);
    }

    Widget? suffixIcon = widget.suffixIcon;
    if (widget.isPassword) {
      suffixIcon = IconButton(
        icon: Icon(_obscureText
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined),
        onPressed: () => setState(() => _obscureText = !_obscureText),
        tooltip: _obscureText ? 'Show password' : 'Hide password',
      );
    } else if (widget.isSearch && _hasText) {
      suffixIcon = IconButton(
        icon: const Icon(Icons.clear),
        onPressed: _clearText,
        tooltip: 'Clear search',
      );
    }

    return InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      prefixIcon: widget.prefixIcon,
      suffixIcon: suffixIcon,
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      errorText: _errorText,

      // Styling
      filled: style.filled,
      fillColor: style.fillColor?.toColor(context) ??
          surfaceColor.withOpacity(0.05),

      contentPadding: style.contentPadding,

      // Label styling
      labelStyle: style.labelStyle?.toTextStyle(context) ??
          theme.textTheme.bodyMedium?.copyWith(
            color: getLabelColor(),
          ),
      floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
        color: getLabelColor(),
        fontWeight: FontWeight.w500,
      ),

      // Hint styling
      hintStyle: style.hintStyle?.toTextStyle(context) ??
          theme.textTheme.bodyMedium?.copyWith(
            color: contentColor.withOpacity(0.5),
          ),

      // Border styling
      border: style.border ??
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
    );
  }
}

/// Style configuration for ModernTextField
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
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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

  /// Style for prominent fields like search
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
