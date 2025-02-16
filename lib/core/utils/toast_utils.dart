import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/utils/toast_enums.dart';
import 'package:ttld/core/utils/toast_notification.dart';

class ToastUtils {
  // static void showSuccessToast(
  //   BuildContext context, {
  //   required String message,
  //   Duration? duration,
  // }) {
  //   showToast(
  //     context,
  //     message: message ,
  //     icon: const FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white),
  //     backgroundColor: Colors.green,
  //     duration: duration,
  //   );
  // }

  static void showToastSuccess(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style,
      required String message}) {
    showToast(context,
        title: title ?? "Success",
        description: description,
        style: style ?? ToastNotificationStyleType.success);
  }

  static void showToastSorry(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Sorry",
        description: description,
        style: style ?? ToastNotificationStyleType.danger);
  }

  /// Displays a Toast message containing "Warning" for the title, you
  /// only need to provide a [description].
  static void showToastWarning(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Warning",
        description: description,
        style: style ?? ToastNotificationStyleType.warning);
  }

  /// Displays a Toast message containing "Info" for the title, you
  /// only need to provide a [description].
  static void showToastInfo(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Info",
        description: description,
        style: style ?? ToastNotificationStyleType.info);
  }

  /// Displays a Toast message containing "Error" for the title, you
  /// only need to provide a [description].
  static void showToastDanger(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Error",
        description: description,
        style: style ?? ToastNotificationStyleType.danger);
  }

  /// Displays a Toast message containing "Oops" for the title, you
  /// only need to provide a [description].
  static void showToastOops(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Oops",
        description: description,
        style: style ?? ToastNotificationStyleType.danger);
  }

  static void showToast(BuildContext context,
      {ToastNotificationStyleType style = ToastNotificationStyleType.success,
      required String title,
      required String description,
      IconData? icon,
      Duration? duration}) {
    showToastNotification(
      context,
      style: style,
      title: title,
      description: description,
      icon: icon,
      duration: duration,
    );
  }
}
