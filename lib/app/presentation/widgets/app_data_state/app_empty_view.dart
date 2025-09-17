import 'package:flutter/material.dart';
import '../app_text.dart';

class AppEmptyView extends StatelessWidget {
  final String? emptyText;

  const AppEmptyView({
    super.key,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Add a Lottie or illustration for empty state
            if (emptyText != null && emptyText!.isNotEmpty)
              AppText(
                text: emptyText!,
                fontSize: 18,
                maxLines: 3,
                centerText: true,
              ),
          ],
        ),
      ),
    );
  }
}
