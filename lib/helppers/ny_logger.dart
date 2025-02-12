import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/helppers/help.dart';

class NyLogger {
  /// Logs a debug [message] to the console.
  /// It will only print if your app's environment is in debug mode.
  /// You can override this by setting [alwaysPrint] = true.
  static debug(dynamic message, {bool alwaysPrint = false}) {
    _loggerPrint(message ?? "", 'debug', alwaysPrint);
  }

  /// Logs an error [message] to the console.
  /// It will only print if your app's environment is in debug mode.
  /// You can override this by setting [alwaysPrint] = true.
  static error(dynamic message, {bool alwaysPrint = false}) {
    if (message is Exception) {
      _loggerPrint(message.toString(), 'error', alwaysPrint);
      return;
    }
    _loggerPrint(message, 'error', alwaysPrint);
  }

  /// Log an info [message] to the console.
  /// It will only print if your app's environment is in debug mode.
  /// You can override this by setting [alwaysPrint] = true.
  static info(dynamic message, {bool alwaysPrint = false}) {
    _loggerPrint(message ?? "", 'info', alwaysPrint);
  }

  /// Dumps a [message] with a tag.
  static dump(dynamic message, String? tag, {bool alwaysPrint = false}) {
    _loggerPrint(message ?? "", tag, alwaysPrint);
  }

  /// Log json data [message] to the console.
  /// It will only print if your app's environment is in debug mode.
  /// You can override this by setting [alwaysPrint] = true.
  static json(dynamic message, {bool alwaysPrint = false}) {
    bool canPrint = (getEnv('APP_DEBUG', defaultValue: true));
    if (!canPrint && !alwaysPrint) return;
    try {
      log(jsonEncode(message));
    } on Exception catch (e) {
      NyLogger.error(e.toString());
    }
  }

  /// Print a new log message
  static _loggerPrint(dynamic message, String? type, bool alwaysPrint) {
    bool canPrint = (getEnv('APP_DEBUG', defaultValue: true));
    // bool showLog = Backpack.instance.read('SHOW_LOG', defaultValue: false);
    bool showLog = false;
    if (!showLog && !canPrint && !alwaysPrint) return;
    if (showLog) {
      // backpackSave('SHOW_LOG', false);
    }
    try {
      if (shouldShowDateTime()) {
        String dateTimeFormatted = "${DateTime.now().toDateTimeString()}";
        _logMessage(
            '[$dateTimeFormatted] ${type != null ? "[$type] " : ""}$message');
        return;
      }
      _logMessage('${type != null ? "[$type] " : ""}$message');
    } on Exception catch (_) {
      _logMessage('${type != null ? "[$type] " : ""}$message');
    }
  }

  static bool shouldShowDateTime() {
    return true; // You can customize this based on your needs
  }

  /// Log a message to the console.
  static _logMessage(dynamic message) {
    if (kDebugMode) {
      if (message is String && message.length > 800) {
        log(message);
        return;
      }
      print(message);
    }
  }
}
