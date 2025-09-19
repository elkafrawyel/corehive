import 'package:flutter/material.dart';

import '../extension/color_extension.dart';

class AppColors extends ThemeExtension<AppColors> {
  // Dynamic colors
  final Color kPrimaryColor;
  final Color kSecondaryColor;
  final Color kBackgroundColor;
  final Color kTextColor;
  final Color kColorOnPrimaryColor;
  final Color kHintColor;
  final Color kErrorColor;
  final Color kSuccessColor;
  final Color kTextFieldColor;

  /// dynamic colors
  const AppColors({
    required this.kPrimaryColor,
    required this.kSecondaryColor,
    required this.kBackgroundColor,
    required this.kTextColor,
    required this.kColorOnPrimaryColor,
    required this.kHintColor,
    required this.kErrorColor,
    required this.kSuccessColor,
    required this.kTextFieldColor,
  });

  factory AppColors.fromColors({
    required String primaryColor,
    required String secondaryColor,
    required String backgroundColor,
    required String textColor,
    required String textOnPrimaryColor,
    required String hintColor,
    required String errorColor,
    required String successColor,
    required String textFieldColor,
  }) {
    return AppColors(
      kPrimaryColor: primaryColor.contains('#')
          ? HexColor.fromHex(primaryColor)
          : RgbColor.fromRgbString(primaryColor),
      kSecondaryColor: secondaryColor.contains('#')
          ? HexColor.fromHex(secondaryColor)
          : RgbColor.fromRgbString(secondaryColor),
      kBackgroundColor: backgroundColor.contains('#')
          ? HexColor.fromHex(backgroundColor)
          : RgbColor.fromRgbString(backgroundColor),
      kTextColor: textColor.contains('#')
          ? HexColor.fromHex(textColor)
          : RgbColor.fromRgbString(textColor),
      kColorOnPrimaryColor: textOnPrimaryColor.contains('#')
          ? HexColor.fromHex(textOnPrimaryColor)
          : RgbColor.fromRgbString(textOnPrimaryColor),
      kHintColor: hintColor.contains('#')
          ? HexColor.fromHex(hintColor)
          : RgbColor.fromRgbString(hintColor),
      kErrorColor: errorColor.contains('#')
          ? HexColor.fromHex(errorColor)
          : RgbColor.fromRgbString(errorColor),
      kSuccessColor: successColor.contains('#')
          ? HexColor.fromHex(successColor)
          : RgbColor.fromRgbString(successColor),
      kTextFieldColor: textFieldColor.contains('#')
          ? HexColor.fromHex(textFieldColor)
          : RgbColor.fromRgbString(textFieldColor),
    );
  }

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? primaryLightColor,
    Color? backgroundColor,
    Color? textColor,
    Color? textOnPrimaryColor,
    Color? hintColor,
    Color? errorColor,
    Color? successColor,
    Color? textFieldColor,
  }) {
    return AppColors(
      kPrimaryColor: primaryColor ?? kPrimaryColor,
      kSecondaryColor: primaryLightColor ?? kSecondaryColor,
      kBackgroundColor: backgroundColor ?? kBackgroundColor,
      kTextColor: textColor ?? kTextColor,
      kColorOnPrimaryColor: textOnPrimaryColor ?? kColorOnPrimaryColor,
      kHintColor: hintColor ?? kHintColor,
      kErrorColor: errorColor ?? kErrorColor,
      kSuccessColor: successColor ?? kSuccessColor,
      kTextFieldColor: textFieldColor ?? kTextFieldColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      kPrimaryColor: Color.lerp(kPrimaryColor, other.kPrimaryColor, t)!,
      kSecondaryColor: Color.lerp(kSecondaryColor, other.kSecondaryColor, t)!,
      kBackgroundColor: Color.lerp(
        kBackgroundColor,
        other.kBackgroundColor,
        t,
      )!,
      kHintColor: Color.lerp(kHintColor, other.kHintColor, t)!,
      kColorOnPrimaryColor: Color.lerp(
        kColorOnPrimaryColor,
        other.kColorOnPrimaryColor,
        t,
      )!,
      kTextColor: Color.lerp(kTextColor, other.kTextColor, t)!,
      kErrorColor: Color.lerp(kErrorColor, other.kErrorColor, t)!,
      kSuccessColor: Color.lerp(kSuccessColor, other.kSuccessColor, t)!,
      kTextFieldColor: Color.lerp(kTextFieldColor, other.kTextFieldColor, t)!,
    );
  }

  static AppColors lightModeColors = const AppColors(
    kPrimaryColor: Color(0xFFFFC107),
    // Vibrant yellow (primary)
    kSecondaryColor: Color(0xFFFF6F00),
    // Deep orange accent
    kBackgroundColor: Color(0xFFFDF8F1),
    // Warm off-white
    kTextColor: Color(0xFF2E2E2E),
    // Dark gray text
    kColorOnPrimaryColor: Color(0xFFFFFFFF),
    // Text on yellow
    kHintColor: Color(0xFF9E9E9E),
    // Neutral gray for hints
    kErrorColor: Color(0xFFD32F2F),
    // Modern red for errors
    kSuccessColor: Color(0xFF388E3C),
    // Balanced green for success
    kTextFieldColor: Color(0xFFF5F5F5), // Light neutral input fields
  );

  static AppColors darkModeColors = const AppColors(
    kPrimaryColor: Color(0xFFFFC107),
    // Yellow primary
    kSecondaryColor: Color(0xFFFFA000),
    // Soft orange accent
    kBackgroundColor: Color(0xFF121212),
    // Dark background
    kTextColor: Color(0xFFE0E0E0),
    // Light gray text
    kColorOnPrimaryColor: Color(0xFF1E1E1E),
    // Text on yellow
    kHintColor: Color(0xFFB0B0B0),
    // Light gray for hints
    kErrorColor: Color(0xFFEF5350),
    // Soft red
    kSuccessColor: Color(0xFF66BB6A),
    // Soft green
    kTextFieldColor: Color(0xFF1E1E1E), // Dark input fields
  );
}
