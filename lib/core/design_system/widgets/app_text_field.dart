import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';

/// Modern text field component with consistent styling
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showPasswordToggle;
  final bool showClearButton;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.showPasswordToggle = false,
    this.showClearButton = false,
  });

  factory AppTextField.email({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    String? Function(String?)? validator,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Email',
      hint: hint ?? 'Enter your email',
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email_outlined, color: AppColors.neutral500),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
    );
  }

  factory AppTextField.password({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    String? Function(String?)? validator,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Password',
      hint: hint ?? 'Enter your password',
      controller: controller,
      focusNode: focusNode,
      obscureText: true,
      showPasswordToggle: true,
      prefixIcon: Icon(Icons.lock_outlined, color: AppColors.neutral500),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
    );
  }

  factory AppTextField.search({
    Key? key,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return AppTextField(
      key: key,
      hint: hint ?? 'Search...',
      controller: controller,
      focusNode: focusNode,
      prefixIcon: Icon(Icons.search, color: AppColors.neutral500),
      showClearButton: true,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon = widget.suffixIcon;

    if (widget.showPasswordToggle) {
      suffixIcon = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.neutral500,
        ),
        onPressed: _togglePasswordVisibility,
      );
    } else if (widget.showClearButton && _hasText) {
      suffixIcon = IconButton(
        icon: Icon(Icons.clear, color: AppColors.neutral500),
        onPressed: _clearText,
      );
    }

    return Column(
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
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.surfaceLight,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            labelStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
            helperStyle: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            errorStyle: AppTypography.bodySmall.copyWith(
              color: AppColors.error,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.input,
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.input,
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.input,
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.input,
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.input,
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.input,
              borderSide: BorderSide(color: AppColors.borderLight),
            ),
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
        ),
      ],
    );
  }
}
