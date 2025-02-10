import 'package:ttld/helppers/help.dart';
import 'package:ttld/themes/base_theme_config.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:ttld/themes/colors/dark_theme_color.dart';
import 'package:ttld/themes/colors/light_theme_color.dart';
import 'package:ttld/themes/dart_theme.dart';
import 'package:ttld/themes/light_theme.dart';

final List<BaseThemeConfig<ColorStyles>> appThemes = [
  BaseThemeConfig<ColorStyles>(
    id: getEnv('LIGHT_THEME_ID'),
    description: "Light theme",
    theme: lightTheme,
    colors: LightThemeColors(),
  ),
  BaseThemeConfig<ColorStyles>(
    id: getEnv('DARK_THEME_ID'),
    description: "Dark theme",
    theme: darkTheme,
    colors: DarkThemeColors(),
  ),
];
