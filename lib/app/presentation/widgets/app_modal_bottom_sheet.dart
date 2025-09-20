import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Custom App Modal Bottom Sheet with animations.
///
/// Example:
/// ```dart
/// await showAppModalBottomSheet(
///   context: context,
///   child: YourBottomSheetWidget(),
/// );
/// ```
Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  ScrollController? scrollController,
  bool isDismissible = true,
  bool enableDrag = false,
  Color barrierColor = Colors.black54,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    barrierColor: barrierColor,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: context.kBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child:
            Padding(
                  // This ensures the sheet avoids the keyboard and fits content height
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: child,
                  ),
                )
                .animate()
                .fade(
                  begin: 0,
                  end: 1,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 200),
                )
                .slide(
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                ),
      );
    },
  );
}
