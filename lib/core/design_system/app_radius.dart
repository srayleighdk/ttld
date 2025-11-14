import 'package:flutter/material.dart';

/// Border radius system for the TTLD application
/// Provides consistent border radius values across the app
class AppRadius {
  AppRadius._();

  // Radius values
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 9999;

  // BorderRadius objects
  static const BorderRadius radiusNone = BorderRadius.zero;
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius radiusFull = BorderRadius.all(Radius.circular(full));

  // Common component radius
  static const BorderRadius button = radiusMD;
  static const BorderRadius card = radiusLG;
  static const BorderRadius input = radiusMD;
  static const BorderRadius dialog = radiusXL;
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );
}
