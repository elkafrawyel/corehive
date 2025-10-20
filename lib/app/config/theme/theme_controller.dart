import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../clients/storage/storage_client.dart';
import 'app_colors.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  final Rx<AppColors> appColors = AppColors.lightModeColors.obs;
  final RxBool isDarkMode = false.obs;
  Rx<ThemeData> currentTheme = ThemeData.light().obs;

  @override
  void onInit() {
    super.onInit();
    _applySavedTheme();
  }

  Future<void> toggleAppTheme() async {
    final newMode = !isDarkMode.value;
    isDarkMode.value = newMode;

    // Save preference
    await StorageClient().save(StorageClientKeys.isDarkMode, newMode);

    // Update AppColors
    final newColors = newMode
        ? AppColors.darkModeColors
        : AppColors.lightModeColors;
    _updateColorsTheme(newColors);

    // Update ThemeData safely
    currentTheme.value = ThemeData(
      brightness: newMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: newColors.kBackgroundColor,
      primaryColor: newColors.kPrimaryColor,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: newColors.kBackgroundColor,
      ),
      extensions: [newColors], // Always attach AppColors
    );
  }

  void _applySavedTheme() async {
    final savedMode =
        StorageClient().get(StorageClientKeys.isDarkMode) as bool? ?? false;
    isDarkMode.value = savedMode;

    final colors = savedMode
        ? AppColors.darkModeColors
        : AppColors.lightModeColors;
    _updateColorsTheme(colors);

    currentTheme.value = ThemeData(
      brightness: savedMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: colors.kBackgroundColor,
      primaryColor: colors.kPrimaryColor,
      useMaterial3: true,
      extensions: [colors],
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: colors.kBackgroundColor,
      ),
    );
  }

  void _updateColorsTheme(AppColors colors) {
    appColors.value = colors;
  }
}
