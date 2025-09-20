import 'package:flutter/material.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';

class OrdersEmptyView extends StatelessWidget {
  final String message;
  final bool showButton;
  final VoidCallback? onButtonPressed;

  const OrdersEmptyView({
    super.key,
    this.message = 'You have not placed any orders yet.',
    this.showButton = true,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox, size: 64, color: context.kHintTextColor),
          const SizedBox(height: 16),
          AppText(
            text: 'No orders found',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: context.kHintTextColor,
          ),
          const SizedBox(height: 8),
          AppText(text: message, fontSize: 14, color: context.kHintTextColor),
          if (showButton) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onButtonPressed,
              child: AppText(
                text: 'Start Shopping Now',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
