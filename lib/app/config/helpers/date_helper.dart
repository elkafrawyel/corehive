import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import '../clients/storage/storage_client.dart';

class DateHelper {
  String _locale() => StorageClient().getAppLanguage();

  /// Returns formatted time from a DateTime or String.
  String getTime(dynamic input, {DateFormat? format}) {
    final date = _parseDate(input);
    if (date == null) return '';
    return (format ?? DateFormat(DateFormat.HOUR_MINUTE, _locale()))
        .format(date);
  }

  /// Returns formatted date from a DateTime or String.
  String getDate(dynamic input, {DateFormat? format}) {
    final date = _parseDate(input);
    if (date == null) return '';
    return (format ?? DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, _locale()))
        .format(date);
  }

  /// Checks if given date string is today.
  bool isToday(String dateString) {
    final date = _parseDate(dateString);
    if (date == null) return false;
    return DateUtils.isSameDay(date, DateTime.now());
  }

  /// Checks if given date string is yesterday.
  bool isYesterday(String dateString) {
    final date = _parseDate(dateString);
    if (date == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return DateUtils.isSameDay(date, yesterday);
  }

  /// Formats a date string into human-readable text.
  /// today → "today • HH:mm"
  /// yesterday → "yesterday • HH:mm"
  /// else → "d MMM y • HH:mm"
  String formatDateTime(String? input) {
    final date = _parseDate(input);
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final inputDate = DateTime(date.year, date.month, date.day);

    final timeFormat = DateFormat.jm(_locale());

    if (inputDate == today) {
      return '${'today'.tr} • ${timeFormat.format(date)}';
    } else if (inputDate == yesterday) {
      return '${'yesterday'.tr} • ${timeFormat.format(date)}';
    } else {
      final fullDateFormat = DateFormat('d MMM y', _locale());
      return '${fullDateFormat.format(date)} • ${timeFormat.format(date)}';
    }
  }

  /// Safely parses input (DateTime or ISO string).
  DateTime? _parseDate(dynamic input) {
    if (input == null) return null;
    if (input is DateTime) return input;
    if (input is String && input.isNotEmpty) {
      try {
        return DateTime.parse(input).toLocal();
      } catch (_) {
        return null; // fallback for bad format
      }
    }
    return null;
  }
}
