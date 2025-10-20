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
  final Color kCardBackgroundColor;

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
    required this.kCardBackgroundColor,
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
    required String cardBackgroundColor,
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
      kCardBackgroundColor: cardBackgroundColor.contains('#')
          ? HexColor.fromHex(cardBackgroundColor)
          : RgbColor.fromRgbString(cardBackgroundColor),
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
    Color? cardBackgroundColor,
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
      kCardBackgroundColor: cardBackgroundColor ?? kCardBackgroundColor,
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
      kCardBackgroundColor: Color.lerp(
        kCardBackgroundColor,
        other.kCardBackgroundColor,
        t,
      )!,
    );
  }

  static AppColors lightModeColors = const AppColors(
    kPrimaryColor: Color(0xFFB8860B),
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
    kCardBackgroundColor: Color(0xFFFFFFFF), // Card background (white)
  );

  static AppColors darkModeColors = const AppColors(
    // Dark Mode primary: brighter green for better contrast
    kPrimaryColor: Color(0xFF3FA34D),
    // Secondary: slightly lighter green for visibility
    kSecondaryColor: Color(0xFF9ED56A),
    // Background: deep dark, reduces eye strain
    kBackgroundColor: Color(0xFF121A2F),
    // On Surface (High-Emphasis Text): almost white
    kTextColor: Color(0xFFFFFFFF),
    // On Primary: white for strong contrast
    kColorOnPrimaryColor: Color(0xFFFFFFFF),
    // On Surface Variant (Medium-Emphasis Text): light gray
    kHintColor: Color(0xB3FFFFFF), // 70% opacity
    // Error: soft red, visible on dark background
    kErrorColor: Color(0xFFFF6B6B),
    // Success: bright green for readability
    kSuccessColor: Color(0xFF4CAF50),
    // Text field fill (Surface): dark gray for inputs
    kTextFieldColor: Color(0xFF1E1E1E),
    // Surface (cards, app bars): dark but slightly lighter than background
    kCardBackgroundColor: Color(0xFF1B2438),
  );
}
