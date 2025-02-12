import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ttld/themes/base_theme_config.dart';

dynamic getEnv(String key, {dynamic defaultValue}) {
  if (!dotenv.env.containsKey(key) && defaultValue != null) {
    return defaultValue;
  }

  String? value = dotenv.env[key];

  if (value == 'null' || value == null) {
    return null;
  }

  if (value.toLowerCase() == 'true') {
    return true;
  }

  if (value.toLowerCase() == 'false') {
    return false;
  }

  return value.toString();
}

List<AppTheme> getAppThemes(List<BaseThemeConfig> test) {
  return test.map((appTheme) => appTheme.toAppTheme()).toList();
}

extension NyAppTheme on List<AppTheme> {
  get darkTheme {
    return firstWhere((theme) => theme.id == getEnv('DARK_THEME_ID'),
        orElse: () => first).data;
  }
}

Color nyHexColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
