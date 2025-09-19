import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:corehive_store/app/config/helpers/logging_helper.dart';

enum StorageClientKeys {
  language, // String
  notifications, // int
  apiToken, // String
  apiTokenType, // String
  isDarkMode, // bool
}

class StorageClient {
  static final StorageClient instance = StorageClient._internal();
  factory StorageClient() => instance;
  StorageClient._internal();

  final GetStorage _box = GetStorage();

  /// Initialize storage before running the app
  Future<void> init() async {
    await GetStorage.init();
  }

  /// ============= Language =============
  String getAppLanguage() {
    return _box.read(StorageClientKeys.language.name) ??
        Get.deviceLocale?.languageCode ??
        'en';
  }

  Future<void> setLanguage(String langCode) async {
    await _box.write(StorageClientKeys.language.name, langCode);
    Get.updateLocale(Locale(langCode));
  }

  bool isAr() => getAppLanguage() == 'ar';

  /// ============= Theme =============
  bool isDarkMode() => _box.read(StorageClientKeys.isDarkMode.name) ?? false;

  Future<void> toggleDarkMode() async {
    bool newValue = !isDarkMode();
    await _box.write(StorageClientKeys.isDarkMode.name, newValue);
    Get.changeThemeMode(newValue ? ThemeMode.dark : ThemeMode.light);
  }

  /// ============= Auth =============
  bool isLogged() => _box.read(StorageClientKeys.apiToken.name) != null;

  String? apiToken() => _box.read(StorageClientKeys.apiToken.name);
  String? apiTokenType() => _box.read(StorageClientKeys.apiTokenType.name);

  Future<void> saveToken(String token, {String type = "Bearer"}) async {
    await _box.write(StorageClientKeys.apiToken.name, token);
    await _box.write(StorageClientKeys.apiTokenType.name, type);
  }

  /// ============= Notifications =============
  int getNotificationsCount() =>
      _box.read(StorageClientKeys.notifications.name) ?? 0;

  Future<void> setNotificationsCount(int count) async {
    await _box.write(StorageClientKeys.notifications.name, count);
  }

  /// ============= General Helpers =============
  Future<void> save(StorageClientKeys key, dynamic value) async {
    await _box.write(key.name, value);
    AppLogger.log('Saved ${key.name} = $value');
  }

  dynamic get(StorageClientKeys key) => _box.read(key.name);

  /// Clear all user data
  Future<void> signOut() async {
    String lang = getAppLanguage();
    await _box.erase();
    // preserve language setting
    await _box.write(StorageClientKeys.language.name, lang);
  }
}
