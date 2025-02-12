import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ttld/core/utils/default_toast_notification.dart';
import 'package:ttld/core/utils/toast_enums.dart';
import 'package:ttld/core/utils/toast_meta.dart';

void showToastNotification(
  BuildContext context, {
  ToastNotificationStyleType? style,
  String? title,
  IconData? icon,
  String? description,
  Duration? duration,
  Widget Function(ToastNotificationStyleType,
          Function(ToastNotificationStyleMetaHelper))?
      customToast,
}) {
  ToastNotificationStyleMetaHelper toastNotificationStyleMetaHelper =
      ToastNotificationStyleMetaHelper(style);
  ToastMeta toastMeta = toastNotificationStyleMetaHelper.getValue();

  Widget? toastNotificationWidget;
  if (customToast != null) {
    toastNotificationWidget = customToast(
      style ?? ToastNotificationStyleType.custom,
      (meta) {
        toastNotificationStyleMetaHelper = meta;
        ToastMeta toastNotificationMeta =
            toastNotificationStyleMetaHelper.getValue();
        if (title != null) toastNotificationMeta.title = title;
        if (description != null)
          toastNotificationMeta.description = description;
        return toastNotificationMeta;
      },
    );
  }

  if (title != null) toastMeta.title = title;
  if (description != null) toastMeta.description = description;
  // if (icon != null) toastMeta.icon = icon;

  showToastWidget(
    toastNotificationWidget ??
        DefaultToastNotification(
          toastMeta,
          onDismiss: () {
            ToastManager().dismissAll(showAnim: true);
          },
        ),
    context: context,
    isIgnoring: false,
    position: StyledToastPosition.top,
    animation: StyledToastAnimation.slideFromTopFade,
    duration: duration ?? toastMeta.duration,
  );
}
