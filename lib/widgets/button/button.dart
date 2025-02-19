import 'package:flutter/material.dart';
import 'package:ttld/helppers/loading_styles.dart';
import 'package:ttld/widgets/button/button_state.dart';
import 'package:ttld/widgets/button/partials/gradient_button_widget.dart';
import 'package:ttld/widgets/button/partials/primary_button_widget.dart';
import 'package:ttld/widgets/button/partials/rounded_button_widget.dart';
import 'package:ttld/widgets/button/partials/secondary_button_widget.dart';
import 'package:ttld/widgets/button/partials/text_only_button_widget.dart';
import 'package:ttld/widgets/button/partials/outlined_button_widget.dart'
    as app;
import 'package:ttld/widgets/button/partials/icon_button_widget.dart' as app;
import 'package:ttld/widgets/button/partials/transparency_button_widget.dart';

class Button {
  /// Primary button
  static Widget primary({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return PrimaryButton(
            text: text,
            onPressed: pressed,
            color: color,
            width: width,
            height: height,
          );
        });
  }

  /// Secondary button
  static Widget secondary({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return SecondaryButton(
            text: text,
            onPressed: pressed,
            color: color,
            width: width,
            height: height,
          );
        });
  }

  /// Outlined button
  static Widget outlined({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? borderColor,
    Color? textColor,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
      onSubmit: (onPressed, submitForm),
      onFailure: onFailure,
      showToastError: showToastError,
      loadingStyle: loadingStyle,
      child: (pressed) {
        return app.OutlinedButton(
          text: text,
          onPressed: pressed,
          borderColor: borderColor,
          textColor: textColor,
          width: width,
          height: height,
        );
      },
    );
  }

  /// Text only button
  static Widget textOnly({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? textColor,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return TextOnlyButton(
            text: text,
            onPressed: pressed,
            textColor: textColor,
            width: width,
            height: height,
          );
        });
  }

  /// Icon button
  static Widget icon({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    required Widget icon,
    Color? color,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
      onSubmit: (onPressed, submitForm),
      onFailure: onFailure,
      showToastError: showToastError,
      loadingStyle: loadingStyle,
      child: (pressed) {
        return app.IconButton(
          text: text,
          onPressed: pressed,
          icon: icon,
          color: color,
          width: width,
          height: height,
        );
      },
    );
  }

  /// Gradient button
  static Widget gradient({
    required String text,
    VoidCallback? onPressed,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    (dynamic, Function(dynamic data))? submitForm,
    List<Color> gradientColors = const [Colors.blue, Colors.purple],
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return GradientButton(
            text: text,
            onPressed: pressed,
            gradientColors: gradientColors,
            width: width,
            height: height,
          );
        });
  }

  /// Rounded button
  static Widget rounded({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    BorderRadius? borderRadius,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return RoundedButton(
            text: text,
            onPressed: pressed,
            color: color,
            borderRadius: borderRadius,
            width: width,
            height: height,
          );
        });
  }

  /// Transparency button
  static Widget transparency({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    BorderRadius? borderRadius,
    double? width,
    double height = 30,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return TransparencyButton(
            text: text,
            onPressed: pressed,
            color: color,
            width: width,
            height: height,
          );
        });
  }
}
