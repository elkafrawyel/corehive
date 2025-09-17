import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:oktoast/oktoast.dart' as ok_toast;

import '../presentation/widgets/app_text.dart';


abstract class InformationViewer {
  /// Show a generic toast
  static void showToast({
    required String msg,
    double fontSize = 16.0,
    required Color backgroundColor,
    Color? textColor,
  }) {
    ok_toast.showToast(
      msg,
      textPadding: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      backgroundColor: backgroundColor,
      position: ok_toast.ToastPosition.bottom,
      textStyle: TextStyle(fontSize: fontSize, color: textColor ?? Colors.white),
    );
  }

  /// Show an error toast with red background
  static void showErrorToast({
    required String msg,
    double fontSize = 16.0,
    Color textColor = Colors.white,
  }) {
    showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  /// Show a success toast with green background
  static void showSuccessToast({
    required String msg,
    double fontSize = 16.0,
    Color textColor = Colors.white,
  }) {
    showToast(
      msg: msg,
      backgroundColor: Colors.green,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  /// Show a material SnackBar using Get.context
  static void showSnackBar({
    required String msg,
    int duration = 5,
    Color? bgColor,
  }) {
    final BuildContext? context = Get.context;
    if (context == null) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor ?? context.kPrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: AppText(
          text: msg,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          maxLines: 3,
        ),
        duration: Duration(seconds: duration),
        dismissDirection: DismissDirection.down,
        action: SnackBarAction(
          label: 'ok'.tr,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
      snackBarAnimationStyle: AnimationStyle(
        curve: Curves.fastEaseInToSlowEaseOut,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
