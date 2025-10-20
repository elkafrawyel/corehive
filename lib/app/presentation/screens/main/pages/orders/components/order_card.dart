import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:intl/intl.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import '../../../../../widgets/app_text.dart';
import '../order_status_enum.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final String currency;
  const OrderCard({required this.order, required this.currency, super.key});

  @override
  Widget build(BuildContext context) {
    final orderDate = DateTime.parse(order['date'] as String);
    final formattedDate = DateFormat.yMMMMd().format(orderDate);
    final status = OrderStatus.values.firstWhere(
      (e) => e.label == (order['status'] as String),
      orElse: () => OrderStatus.processing,
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: context.kTextFieldColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            AppNetworkImage(
              imageUrl: order['productImage'] as String?,
              width: 60,
              height: 60,
              radius: 12,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: order['productName'] as String? ?? '',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: context.kTextColor,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    text: 'Qty: ${order['quantity']}',
                    fontSize: 13,
                    color: context.kHintTextColor,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    text: formattedDate,
                    fontSize: 13,
                    color: context.kHintTextColor,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    text: 'Status: ${status.label}',
                    fontSize: 13,
                    color: status == OrderStatus.delivered
                        ? Colors.green
                        : status == OrderStatus.cancelled
                        ? Colors.red
                        : context.kPrimaryColor,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText(
                  text: '${order['total']} $currency',
                  fontWeight: FontWeight.w600,
                  color: context.kPrimaryColor,
                  fontSize: 15,
                ),
                const SizedBox(height: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: context.kPrimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
