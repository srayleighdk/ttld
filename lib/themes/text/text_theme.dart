import 'package:flutter/material.dart';

TextTheme getAppTextTheme(TextStyle appThemeFont, TextTheme textTheme) {
  return TextTheme(
    displayLarge: appThemeFont.merge(textTheme.displayLarge),
    displayMedium: appThemeFont.merge(textTheme.displayMedium),
    displaySmall: appThemeFont.merge(textTheme.displaySmall),
    headlineLarge: appThemeFont.merge(textTheme.headlineLarge),
    headlineMedium: appThemeFont.merge(textTheme.headlineMedium),
    headlineSmall: appThemeFont.merge(textTheme.headlineSmall),
    titleLarge: appThemeFont.merge(textTheme.titleLarge),
    titleMedium: appThemeFont.merge(textTheme.titleMedium),
    titleSmall: appThemeFont.merge(textTheme.titleSmall),
    bodyLarge: appThemeFont.merge(textTheme.bodyLarge),
    bodyMedium: appThemeFont.merge(textTheme.bodyMedium),
    bodySmall: appThemeFont.merge(textTheme.bodySmall),
    labelLarge: appThemeFont.merge(textTheme.labelLarge),
    labelMedium: appThemeFont.merge(textTheme.labelMedium),
    labelSmall: appThemeFont.merge(textTheme.labelSmall),
  );
}

const TextTheme defaultTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  ),
  headlineSmall: TextStyle(
    fontSize: 22.0,
  ),
  headlineMedium: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  ),
  displaySmall: TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w700,
  ),
  displayMedium: TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
  ),
  displayLarge: TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w300,
  ),
  titleSmall: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: TextStyle(),
  bodyLarge: TextStyle(
    fontSize: 18.0,
  ),
  bodyMedium: TextStyle(
    fontSize: 15.5,
  ),
  bodySmall: TextStyle(
    fontSize: 13.0,
  ),
);
