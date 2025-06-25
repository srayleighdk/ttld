import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ttld/helppers/help.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ttld/themes/base_theme_config.dart';
import 'dart:io';

import 'package:ttld/themes/colors/color_style.dart';
import 'package:ttld/themes/text/app_theme.dart';

extension DarkMode on BuildContext {
  /// Example
  /// if (context.isDeviceInDarkMode) {
  ///   do something here...
  /// }
  // The field in widget need to change when need to dark Brightness.light
  bool get isDeviceInDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.light;
}

/// Extensions for [String]
extension NyStr on String? {
  Color toHexColor() => nyHexColor(this ?? "");
}

// Text fontWeightBold() {
//   return copyWith(style: const TextStyle(fontWeight: FontWeight.bold));
// }

/// Extensions for [Map]

/// IterableExtension
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

/// Extensions for [List]
extension ListUpdateExtension<T> on List<T> {
  /// Update a list of items based on a condition.
  List<T> update(bool Function(T) condition, T Function(T) updater) {
    return map((item) {
      if (condition(item)) {
        return updater(item);
      }
      return item;
    }).toList();
  }
}

extension NyRow on Row {
  /// Add padding to the row.
  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: this,
    );
  }

  /// Add symmetric padding to the row.
  Padding paddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  /// Adds a gap between each child.
  Row withGap(double space) {
    assert(space >= 0, 'Space should be a non-negative value.');

    List<Widget> newChildren = [];
    for (int i = 0; i < children.length; i++) {
      newChildren.add(children[i]);
      if (i < children.length - 1) {
        newChildren.add(SizedBox(width: space));
      }
    }

    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: newChildren,
    );
  }

  /// Add a divider between each child.
  /// [width] is the width of the divider.
  /// [color] is the color of the divider.
  /// [thickness] is the thickness of the divider.
  /// [indent] is the indent of the divider.
  /// [endIndent] is the endIndent of the divider.
  /// Example:
  /// ```
  /// Row(
  /// children: [
  ///  Text("Hello"),
  ///  Text("World"),
  /// ]).withDivider(),
  IntrinsicHeight withDivider(
      {double width = 1,
      Color? color,
      double thickness = 1,
      double indent = 0,
      double endIndent = 0}) {
    List<Widget> newChildren = [];
    for (int i = 0; i < children.length; i++) {
      newChildren.add(children[i]);
      if (i < children.length - 1) {
        newChildren.add(VerticalDivider(
          width: width,
          color: color ?? Colors.grey.shade300,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
        ));
      }
    }

    return IntrinsicHeight(
      child: Row(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: newChildren,
      ),
    );
  }
}

extension NyColumn on Column {
  /// Add padding to the column.
  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: this,
    );
  }

  /// Add symmetric padding to the column.
  Padding paddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  /// Adds a gap between each child.
  Column withGap(double space) {
    assert(space >= 0, 'Space should be a non-negative value.');

    List<Widget> newChildren = [];
    for (int i = 0; i < children.length; i++) {
      newChildren.add(children[i]);
      if (i < children.length - 1) {
        newChildren.add(SizedBox(height: space));
      }
    }

    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: newChildren,
    );
  }

  /// Make a Column [Flexible].
  /// Example:
  /// ```
  /// Column(
  ///  children: [
  ///  MaterialButton(child: Text('Button 1'), onPressed: () {}).flexible(),
  ///  MaterialButton(child: Text('Button 2'), onPressed: () {}).flexible(),
  ///  ],
  ///  ),
  ///  ```
  Flexible flexible({Key? key, int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(
      key: key,
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  /// Make a Column [Expanded].
  /// Example:
  /// ```
  /// Column(
  ///  children: [
  ///  MaterialButton(child: Text('Button 1'), onPressed: () {}).expanded(),
  ///  Text("Hello world"),
  ///  ],
  ///  ),
  ///  ```
  Expanded expanded({Key? key, int flex = 1}) {
    return Expanded(
      key: key,
      flex: flex,
      child: this,
    );
  }
}

extension NyListWidget on List<Widget> {
  /// Add a gap between each child.
  List<Widget> withGap(double space) {
    assert(space >= 0, 'Space should be a non-negative value.');

    List<Widget> newChildren = [];
    for (int i = 0; i < length; i++) {
      newChildren.add(this[i]);
      if (i < length - 1) {
        newChildren.add(SizedBox(height: space));
      }
    }

    return newChildren;
  }
}

extension NyWidget on Widget {
  /// Make a widget a skeleton using the [Skeletonizer] package.
  Skeletonizer toSkeleton({
    Key? key,
    bool? ignoreContainers,
    bool? justifyMultiLineText,
    Color? containersColor,
    bool ignorePointers = true,
    bool enabled = true,
    PaintingEffect? effect,
    TextBoneBorderRadius? textBoneBorderRadius,
  }) {
    return Skeletonizer(
      ignoreContainers: ignoreContainers,
      enabled: enabled,
      effect: effect,
      textBoneBorderRadius: textBoneBorderRadius,
      justifyMultiLineText: justifyMultiLineText,
      containersColor: containersColor,
      ignorePointers: ignorePointers,
      child: this,
    );
  }
}

class ThemeColor {
  static ColorStyles get(BuildContext context, {String? themeId}) =>
      nyColorStyle<ColorStyles>(context, themeId: themeId);

  static Color fromHex(String hexColor) => nyHexColor(hexColor);
}

/// [BuildContext] Extensions
extension NyApp on BuildContext {
  /// Get the current theme color
  ColorStyles get color => ThemeColor.get(this);
}

T nyColorStyle<T>(BuildContext context, {String? themeId}) {
  List<AppTheme> appThemes = getAppThemes();

  if (themeId == null) {
    AppTheme themeFound = appThemes.firstWhere((theme) {
      if (context.isDeviceInDarkMode) {
        return theme.id == getEnv('DARK_THEME_ID');
      }
      return theme.id == ThemeProvider.controllerOf(context).currentThemeId;
    }, orElse: () => appThemes.first);
    return (themeFound.options as NyThemeOptions).colors;
  }

  AppTheme themeFound = appThemes.firstWhere((theme) => theme.id == themeId,
      orElse: () => appThemes.first);
  return (themeFound.options as NyThemeOptions).colors;
}

List<AppTheme> getAppThemes() {
  return appThemes.map((appTheme) => appTheme.toAppTheme()).toList();
}
