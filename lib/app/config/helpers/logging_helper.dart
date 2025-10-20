import 'package:flutter/foundation.dart';
import 'package:get/utils.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 1000,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
      noBoxingByDefault: true,
    ),
  );

  /// Main logging function
  static void log(
      dynamic message, {
        Level level = Level.info,
        String? tag,
        bool useGetX = false,
      }) {
    if (kDebugMode) {
      final msg = tag != null ? "[$tag] $message" : message;
      if (useGetX) {
        Get.log(msg.toString());
      } else {
        _logger.log(level, msg);
      }
    }
  }

  /// Shortcut for errors
  static void error(dynamic message, {String? tag}) =>
      log(message, level: Level.error, tag: tag);

  /// Shortcut for warnings
  static void warning(dynamic message, {String? tag}) =>
      log(message, level: Level.warning, tag: tag);

  /// Shortcut for debug
  static void debug(dynamic message, {String? tag}) =>
      log(message, level: Level.debug, tag: tag);
}
