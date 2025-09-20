import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';

import '../../../config/clients/storage/storage_client.dart';
import '../app_button.dart';
import '../app_text.dart';

class AppDisconnectView extends StatelessWidget {
  final VoidCallback? retry;

  const AppDisconnectView({super.key, this.retry});

  @override
  Widget build(BuildContext context) {
    final isArabic = StorageClient().isAr();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0),
              child: AppText(
                text: isArabic
                    ? 'تأكد من اتصالك بالشبكة'
                    : 'Please check your internet connection',
                color: context.kHintTextColor,
                fontSize: 16,
                centerText: true,
              ),
            ),
            30.ph,
            if (retry != null)
              AppButton(
                text: isArabic ? 'إعادة المحاولة' : 'Retry',
                onPressed: retry,
              ),
          ],
        ),
      ),
    );
  }
}
