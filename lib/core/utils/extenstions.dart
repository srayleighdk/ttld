import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ttld/helppers/help.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ttld/helppers/ny_logger.dart';
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

  /// dump the value to the console. [tag] is optional.
  dump({String? tag}) {
    NyLogger.dump(this ?? "", tag);
  }

  /// dump the value to the console and exit the app. [tag] is optional.
  dd({String? tag}) {
    NyLogger.dump(this ?? "", tag);
    exit(0);
  }

  // // /// jsonDecode a [String].
  //  dynamic parseJson() => jsonDecode(this ?? "{}");

  /// Attempt to convert a [String] to a [DateTime].
  DateTime toDateTime() => DateTime.parse(this ?? "");
}

// Text fontWeightBold() {
//   return copyWith(style: const TextStyle(fontWeight: FontWeight.bold));
// }

extension NyDateTime on DateTime? {
  /// Get the locale of the device.
  // String? get _locale => NyLocalization.instance.languageCode;

  /// Check if the date is still valid.
  bool hasExpired() {
    if (this == null) return true;
    return isInPast();
  }

  /// Check if the date is in the morning.
  bool isMorning() {
    if (this == null) return false;
    if (this?.hour == null) return false;
    return this!.hour >= 0 && this!.hour < 12;
  }

  /// Check if the date is in the afternoon.
  bool isAfternoon() {
    if (this == null) return false;
    if (this?.hour == null) return false;
    return this!.hour >= 12 && this!.hour < 18;
  }

  /// Check if the date is in the evening.
  bool isEvening() {
    if (this == null) return false;
    if (this?.hour == null) return false;
    return this!.hour >= 18 && this!.hour < 24;
  }

  /// Check if the date is in the night.
  bool isNight() {
    if (this == null) return false;
    if (this?.hour == null) return false;
    return this!.hour >= 0 && this!.hour < 6;
  }

  /// Add years to a [DateTime]
  DateTime addYears(int years) {
    if (this == null) throw Exception("DateTime is null");
    return DateTime(this!.year + years, this!.month, this!.day);
  }

  /// Subtract years from a [DateTime]
  DateTime subtractYears(int years) {
    if (this == null) throw Exception("DateTime is null");
    return DateTime(this!.year - years, this!.month, this!.day);
  }

  /// Add months to a [DateTime]
  DateTime addMonths(int months) {
    if (this == null) throw Exception("DateTime is null");
    return DateTime(this!.year, this!.month + months, this!.day);
  }

  /// Subtract months from a [DateTime]
  DateTime subtractMonths(int months) {
    if (this == null) throw Exception("DateTime is null");
    return DateTime(this!.year, this!.month - months, this!.day);
  }

  /// Add days to a [DateTime]
  DateTime addDays(int days) {
    if (this == null) throw Exception("DateTime is null");
    return this!.add(Duration(days: days));
  }

  /// Subtract days from a [DateTime]
  DateTime subtractDays(int days) {
    if (this == null) throw Exception("DateTime is null");
    return this!.subtract(Duration(days: days));
  }

  /// Add hours to a [DateTime]
  DateTime addHours(int hours) {
    if (this == null) throw Exception("DateTime is null");
    return this!.add(Duration(hours: hours));
  }

  /// Subtract hours from a [DateTime]
  DateTime subtractHours(int hours) {
    if (this == null) throw Exception("DateTime is null");
    return this!.subtract(Duration(hours: hours));
  }

  DateTime addMinutes(int minutes) {
    if (this == null) throw Exception("DateTime is null");
    return this!.add(Duration(minutes: minutes));
  }

  /// Subtract minutes from a [DateTime]
  DateTime subtractMinutes(int minutes) {
    if (this == null) throw Exception("DateTime is null");
    return this!.subtract(Duration(minutes: minutes));
  }

  /// Add seconds to a [DateTime]
  DateTime addSeconds(int seconds) {
    if (this == null) throw Exception("DateTime is null");
    return this!.add(Duration(seconds: seconds));
  }

  /// Subtract seconds from a [DateTime]
  DateTime subtractSeconds(int seconds) {
    if (this == null) throw Exception("DateTime is null");
    return this!.subtract(Duration(seconds: seconds));
  }

  // Format [DateTime] to DateTimeString - yyyy-MM-dd HH:mm:ss
  String? toDateTimeString() {
    if (this == null) return null;
    return intl.DateFormat("yyyy-MM-dd HH:mm:ss").format(this!);
  }

  /// Format [DateTime] to toDateString - yyyy-MM-dd
  // String? toDateString({String format = "yyyy-MM-dd"}) {
  //   if (this == null) return null;
  //   return intl.DateFormat(format, _locale).format(this!);
  // }

  /// Format [DateTime] to toDateString - yyyy-MM-dd
  // String? toDateStringUK({String format = "dd/MM/yyyy"}) {
  //   return toDateString(format: format);
  // }
  //
  // /// Format [DateTime] to toDateString - yyyy-MM-dd
  // String? toDateStringUS({String format = "MM/dd/yyyy"}) {
  //   return toDateString(format: format);
  // }

  /// Format [DateTime] to toTimeString - HH:mm or HH:mm:ss
  // String? toTimeString({bool withSeconds = false}) {
  //   if (this == null) return null;
  //   String format = "HH:mm";
  //   if (withSeconds) format = "HH:mm:ss";
  //   return intl.DateFormat(format, _locale).format(this!);
  // }

  /// Format [DateTime] to an age
  int? toAge() {
    if (this == null) return null;
    return DateTime.now().difference(this!).inDays ~/ 365;
  }

  /// Check if [DateTime] is younger than a certain [age]
  bool? isAgeYounger(int age) {
    if (this == null) return null;
    int? ageCheck = toAge();
    if (ageCheck == null) return null;
    return ageCheck < age;
  }

  /// Check if [DateTime] is older than a certain [age]
  bool? isAgeOlder(int age) {
    if (this == null) return null;
    int? ageCheck = toAge();
    if (ageCheck == null) return null;
    return ageCheck > age;
  }

  /// Check if [DateTime] is between a certain [min] and [max] age
  bool? isAgeBetween(int min, int max) {
    if (this == null) return null;
    int? ageCheck = toAge();
    if (ageCheck == null) return null;
    return ageCheck >= min && ageCheck <= max;
  }

  /// Check if [DateTime] is equal to a certain [age]
  isAgeEqualTo(int age) {
    if (this == null) return null;
    int? ageCheck = toAge();
    if (ageCheck == null) return null;
    return ageCheck == age;
  }

  /// Check if [DateTime] is in the past
  bool isInPast() {
    if (this == null) return false;
    return this!.isBefore(DateTime.now());
  }

  /// Check if [DateTime] is in the future
  bool isInFuture() {
    if (this == null) return false;
    return this!.isAfter(DateTime.now());
  }

  /// Check if [DateTime] is today
  bool isToday() {
    if (this == null) return false;
    DateTime dateTime = DateTime.now();
    return this!.day == dateTime.day &&
        this!.month == dateTime.month &&
        this!.year == dateTime.year;
  }

  /// Check if [DateTime] is tomorrow
  bool isTomorrow() {
    if (this == null) return false;
    DateTime dateTime = DateTime.now().add(const Duration(days: 1));
    return this!.day == dateTime.day &&
        this!.month == dateTime.month &&
        this!.year == dateTime.year;
  }

  /// Check if [DateTime] is yesterday
  bool isYesterday() {
    if (this == null) return false;
    DateTime dateTime = DateTime.now().subtract(const Duration(days: 1));
    return this!.day == dateTime.day &&
        this!.month == dateTime.month &&
        this!.year == dateTime.year;
  }

  /// Get ordinal of the day.
  // String _addOrdinal(int day) {
  //   if (day >= 11 && day <= 13) {
  //     return '${day}th';
  //   }
  //   switch (day % 10) {
  //     case 1:
  //       return '${day}st';
  //     case 2:
  //       return '${day}nd';
  //     case 3:
  //       return '${day}rd';
  //     default:
  //       return '${day}th';
  //   }
  // }

  // Format [DateTime] to a time ago.
  // Example: 2 hours ago
  // String? toTimeAgoString() {
  //   if (this == null) {
  //     'DateTime is null'.dump();
  //     return null;
  //   }
  //   return GetTimeAgo.parse(this!, locale: Nylo.instance.locale);
  // }

  /// Format [DateTime] to a short date - example "Mon 1st Jan"
  // String toShortDate() {
  //   if (this == null) return "";
  //   return '${intl.DateFormat('E', _locale).format(this!)} ${_addOrdinal(this!.day)} ${intl.DateFormat('MMM', _locale).format(this!)}';
  // }

  /// Format [DateTime]
  // String? toFormat(String format) {
  //   if (this == null) return null;
  //   return intl.DateFormat(format, _locale).format(this!);
  // }

  /// Check if a date is the same day as another date.
  /// [dateTime1] and [dateTime2] are the dates to compare.
  bool isSameDay(DateTime dateTimeToCompare) {
    if (this == null) return false;
    return this!.year == dateTimeToCompare.year &&
        this!.month == dateTimeToCompare.month &&
        this!.day == dateTimeToCompare.day;
  }

  /// dump the value to the console. [tag] is optional.
  // dump({String? tag}) {
  //   NyLogger.dump((this ?? "").toString(), tag);
  // }
  //
  // /// dump the value to the console and exit the app. [tag] is optional.
  // dd({String? tag}) {
  //   NyLogger.dump((this ?? "").toString(), tag);
  //   exit(0);
  // }
}

/// Extensions for [Map]
extension NyMap on Map? {
  /// dump the value to the console. [tag] is optional.
  dump({String? tag}) {
    NyLogger.dump((this ?? "").toString(), tag);
  }

  /// dump the value to the console and exit the app. [tag] is optional.
  dd({String? tag}) {
    NyLogger.dump((this ?? "").toString(), tag);
    exit(0);
  }
}

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
