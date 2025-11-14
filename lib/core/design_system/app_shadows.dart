import 'package:flutter/material.dart';
import 'package:ttld/core/design_system/app_colors.dart';

/// Shadow system for the TTLD application
/// Provides consistent elevation and shadow styles
class AppShadows {
  AppShadows._();

  // Shadow levels
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> xs = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];

  // Component-specific shadows
  static const List<BoxShadow> button = sm;
  static const List<BoxShadow> card = md;
  static const List<BoxShadow> dialog = xl;
  static const List<BoxShadow> bottomSheet = lg;
  static const List<BoxShadow> appBar = xs;
}
