import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/utils/toast_enums.dart';
import 'package:ttld/core/utils/toast_notification.dart';

class ToastUtils {
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

  static void showToastWarning(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Warning",
        description: description,
        style: style ?? ToastNotificationStyleType.warning);
  }

  static void showToastInfo(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Info",
        description: description,
        style: style ?? ToastNotificationStyleType.info);
  }

  static void showToastDanger(BuildContext context,
      {String? title,
      required String description,
      ToastNotificationStyleType? style}) {
    showToast(context,
        title: title ?? "Error",
        description: description,
        style: style ?? ToastNotificationStyleType.danger);
  }

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

  // Convenience methods for common toast types
  static void showSuccessToast(BuildContext context, String message) {
    showToast(
      context,
      title: "Success",
      description: message,
      style: ToastNotificationStyleType.success,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    showToast(
      context,
      title: "Error",
      description: message,
      style: ToastNotificationStyleType.danger,
    );
  }

  static void showInfoToast(BuildContext context, String message) {
    showToast(
      context,
      title: "Info",
      description: message,
      style: ToastNotificationStyleType.info,
    );
  }

  static void showWarningToast(BuildContext context, String message) {
    showToast(
      context,
      title: "Warning",
      description: message,
      style: ToastNotificationStyleType.warning,
    );
  }
}