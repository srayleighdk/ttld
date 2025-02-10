import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToastUtils {
  static void showSuccessToast(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _showToast(
      context,
      message: message,
      icon: const FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white),
      backgroundColor: Colors.green,
      duration: duration,
    );
  }

  static void showErrorToast(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _showToast(
      context,
      message: message,
      icon: const FaIcon(FontAwesomeIcons.circleXmark, color: Colors.white),
      backgroundColor: Colors.red,
      duration: duration,
    );
  }

  static void showWarningToast(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _showToast(
      context,
      message: message,
      icon: const FaIcon(FontAwesomeIcons.triangleExclamation,
          color: Colors.white),
      backgroundColor: Colors.orange,
      duration: duration,
    );
  }

  static void showInfoToast(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _showToast(
      context,
      message: message,
      icon: const FaIcon(FontAwesomeIcons.circleInfo, color: Colors.white),
      backgroundColor: Colors.blue,
      duration: duration,
    );
  }

  static void _showToast(
    BuildContext context, {
    required String message,
    required Widget icon,
    required Color backgroundColor,
    Duration? duration,
  }) {
    showToastWidget(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12.0),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(milliseconds: 400),
      duration: duration ?? const Duration(seconds: 4),
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }
}
