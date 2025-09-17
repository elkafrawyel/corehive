import 'package:flutter/material.dart';
import '../../../config/clients/storage/storage_client.dart';
import '../app_button.dart';
import '../app_text.dart';

class AppErrorView extends StatelessWidget {
  final String? error;
  final Function()? retry;

  const AppErrorView({
    super.key,
    this.error,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Add Lottie or illustration for error state
            if (error != null && error!.isNotEmpty)
              AppText(
                text: error!,
                fontWeight: FontWeight.w500,
                maxLines: 10,
                centerText: true,
              ),
            if (retry != null) ...[
              const SizedBox(height: 20),
              AppButton(
                text: StorageClient().isAr() ? 'إعادة المحاولة' : 'Retry',
                onPressed: retry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
