import 'package:flutter/material.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_shadows.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';

/// Modern button component with consistent styling
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
  });

  factory AppButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    Widget? icon,
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.primary,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
    );
  }

  factory AppButton.secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    Widget? icon,
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.secondary,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
    );
  }

  factory AppButton.outline({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    Widget? icon,
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.outline,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
    );
  }

  factory AppButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    Widget? icon,
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.text,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final textStyle = _getTextStyle();
    final padding = _getPadding();
    final height = _getHeight();

    Widget buttonChild = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          SizedBox(width: AppSpacing.sm),
        ],
        if (isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == AppButtonVariant.primary
                    ? AppColors.textOnPrimary
                    : AppColors.primary,
              ),
            ),
          )
        else if (icon != null)
          icon!
        else
          Text(text, style: textStyle),
        if (trailingIcon != null) ...[
          SizedBox(width: AppSpacing.sm),
          trailingIcon!,
        ],
      ],
    );

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonChild,
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.neutral300,
          disabledForegroundColor: AppColors.neutral500,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.button,
          ),
        );

      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.neutral300,
          disabledForegroundColor: AppColors.neutral500,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.button,
          ),
        );

      case AppButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.neutral400,
          side: BorderSide(color: AppColors.primary, width: 1.5),
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.button,
          ),
        );

      case AppButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.neutral400,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.button,
          ),
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return AppTypography.labelMedium.copyWith(
          color: variant == AppButtonVariant.primary ||
                  variant == AppButtonVariant.secondary
              ? AppColors.textOnPrimary
              : AppColors.primary,
        );
      case AppButtonSize.medium:
        return AppTypography.labelLarge.copyWith(
          color: variant == AppButtonVariant.primary ||
                  variant == AppButtonVariant.secondary
              ? AppColors.textOnPrimary
              : AppColors.primary,
        );
      case AppButtonSize.large:
        return AppTypography.buttonLarge.copyWith(
          color: variant == AppButtonVariant.primary ||
                  variant == AppButtonVariant.secondary
              ? AppColors.textOnPrimary
              : AppColors.primary,
        );
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        );
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.md,
        );
      case AppButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: AppSpacing.xxxl,
          vertical: AppSpacing.lg,
        );
    }
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }
}

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

enum AppButtonSize {
  small,
  medium,
  large,
}
