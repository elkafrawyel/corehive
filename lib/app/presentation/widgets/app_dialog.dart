import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import '../../config/clients/storage/storage_client.dart';
import '../../config/constants.dart';

Future<bool> scaleAlertDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmText,
  required String cancelText,
  bool barrierDismissible = false,
  int animationDuration = 400,
}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: title,
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (dialogContext, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);

      return Transform.scale(
        scale: curve,
        child: GetPlatform.isIOS
            ? CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: StorageClient().isDarkMode()
                      ? Brightness.dark
                      : Brightness.light,
                  scaffoldBackgroundColor: context.kBackgroundColor,
                ),
                child: CupertinoAlertDialog(
                  title: AppText(
                    text: title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  content: AppText(
                    text: body,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    maxLines: 5,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext, true); // ✅ return true
                      },
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.kErrorColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(dialogContext, false), // ✅ return false
                      child: Text(
                        cancelText,
                        style: TextStyle(
                          color: context.kPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : AlertDialog(
                title: AppText(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                content: AppText(
                  text: body,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  maxLines: 2,
                ),
                backgroundColor: context.kBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadius),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext, true); // ✅ return true
                    },
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.kErrorColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(dialogContext, false), // ✅ return false
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        color: context.kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
      );
    },
  ).then((value) => value ?? false); // default to false if dismissed
}
