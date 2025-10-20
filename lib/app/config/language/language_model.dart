import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../clients/storage/storage_client.dart';
import '../clients/api/api_client.dart'; // assuming you have this
import '../helpers/logging_helper.dart';     // your AppLogger class

class LanguageData {
  final String flag;
  final String name;
  final String languageCode;
  final String countryCode;

  const LanguageData(this.flag, this.name, this.languageCode, this.countryCode);

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'EG'),
  ];

  /// All available languages
  static List<LanguageData> languageList() {
    return const [
      LanguageData("🇺🇸", "English", "en", "US"),
      LanguageData("🇸🇦", "العربية", "ar", "EG"),
    ];
  }

  /// Current selected language
  static LanguageData get selectedLanguage {
    final storedLang = StorageClient().getAppLanguage();

    return languageList().firstWhere(
          (lang) => lang.languageCode.toLowerCase() == storedLang,
      orElse: () => languageList().first, // fallback = English
    );
  }

  /// Change app language
  static Future<void> changeLanguage(LanguageData value) async {
    AppLogger.log('App Language Changed: ${value.languageCode}');

    final locale = Locale(value.languageCode, value.countryCode);
    await Get.updateLocale(locale);

    await StorageClient().save(StorageClientKeys.language, value.languageCode);
    APIClient.instance.updateAcceptedLanguageHeader(value.languageCode);
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguageData &&
              runtimeType == other.runtimeType &&
              languageCode == other.languageCode &&
              countryCode == other.countryCode;

  @override
  int get hashCode => languageCode.hashCode ^ countryCode.hashCode;
}
