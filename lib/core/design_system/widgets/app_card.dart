import 'package:flutter/material.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_shadows.dart';
import 'package:ttld/core/design_system/app_spacing.dart';

/// Modern card component with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  factory AppCard.elevated({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      padding: padding,
      margin: margin,
      color: color,
      onTap: onTap,
      boxShadow: AppShadows.card,
      child: child,
    );
  }

  factory AppCard.outlined({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      padding: padding,
      margin: margin,
      color: color,
      onTap: onTap,
      border: Border.all(color: AppColors.border),
      boxShadow: [],
      child: child,
    );
  }

  factory AppCard.flat({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      padding: padding,
      margin: margin,
      color: color,
      onTap: onTap,
      boxShadow: [],
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? EdgeInsets.all(AppSpacing.lg),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: borderRadius ?? AppRadius.card,
        boxShadow: boxShadow ?? AppShadows.card,
        border: border,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppRadius.card,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

/// Info card with icon and content
class AppInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const AppInfoCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.elevated(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.primary).withOpacity(0.1),
              borderRadius: AppRadius.radiusMD,
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: 28,
            ),
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (onTap != null)
            Icon(
              Icons.chevron_right,
              color: AppColors.neutral400,
            ),
        ],
      ),
    );
  }
}

/// Stat card for displaying metrics
class AppStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? color;
  final String? trend;
  final bool isPositiveTrend;

  const AppStatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.color,
    this.trend,
    this.isPositiveTrend = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;

    return AppCard.elevated(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (icon != null)
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: effectiveColor.withOpacity(0.1),
                    borderRadius: AppRadius.radiusSM,
                  ),
                  child: Icon(
                    icon,
                    color: effectiveColor,
                    size: 20,
                  ),
                ),
              if (trend != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositiveTrend
                            ? AppColors.success
                            : AppColors.error)
                        .withOpacity(0.1),
                    borderRadius: AppRadius.radiusSM,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositiveTrend
                            ? Icons.trending_up
                            : Icons.trending_down,
                        size: 14,
                        color: isPositiveTrend
                            ? AppColors.success
                            : AppColors.error,
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        trend!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isPositiveTrend
                                  ? AppColors.success
                                  : AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
