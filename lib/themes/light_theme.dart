import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:ttld/themes/text/font.dart';
import 'package:ttld/themes/text/text_theme.dart';

ThemeData lightTheme(ColorStyles color) {
  TextTheme lightTheme =
      getAppTextTheme(appFont, defaultTextTheme.merge(_textTheme(color)));

  return ThemeData(
    useMaterial3: true,
    primaryColor: color.content,
    primaryColorLight: color.primaryAccent,
    focusColor: color.content,
    scaffoldBackgroundColor: color.background,
    hintColor: color.primaryAccent,
    dividerTheme: DividerThemeData(color: Colors.grey[100]),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: color.appBarBackground,
      foregroundColor: color.appBarPrimaryContent,
      titleTextStyle:
          lightTheme.titleLarge!.copyWith(color: color.appBarPrimaryContent),
      iconTheme: IconThemeData(color: color.appBarPrimaryContent),
      actionsIconTheme: IconThemeData(color: color.appBarPrimaryContent),
      elevation: 1.0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: color.buttonContent,
      colorScheme: ColorScheme.light(primary: color.buttonBackground),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: color.content),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: color.buttonContent,
          backgroundColor: color.buttonBackground),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: color.bottomTabBarBackground,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: color.bottomTabBarBackground,
      unselectedIconTheme:
          IconThemeData(color: color.bottomTabBarIconUnselected),
      selectedIconTheme: IconThemeData(color: color.bottomTabBarIconSelected),
      unselectedLabelStyle: TextStyle(color: color.bottomTabBarLabelUnselected),
      selectedLabelStyle: TextStyle(color: color.bottomTabBarLabelSelected),
      selectedItemColor: color.bottomTabBarLabelSelected,
    ),
    textTheme: lightTheme,
    colorScheme: ColorScheme.light(
      surface: color.background,
      onSecondary: Colors.white,
      primary: color.primaryAccent,
    ),
  );
}

/* Light Text Theme
|-------------------------------------------------------------------------*/

TextTheme _textTheme(ColorStyles colors) {
  TextTheme textTheme = const TextTheme().apply(displayColor: colors.content);
  return textTheme.copyWith(
      labelLarge:
          TextStyle(color: colors.content.withAlpha((255.0 * 0.8).round())));
}
