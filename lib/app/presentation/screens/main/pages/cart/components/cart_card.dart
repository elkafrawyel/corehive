import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/domain/entities/cart_model.dart';

import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_network_image.dart';
import '../controller/cart_controller.dart';

class CartCard extends StatefulWidget {
  final CartItem item;

  const CartCard({required this.item, super.key});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 👈 ensures the widget is kept alive

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppCard(
      child: Row(
        children: [
          // ✅ Product Image with shimmer + error handling
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppNetworkImage(
              imageUrl: widget.item.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // ✅ Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: context.h6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.kTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  "\$${widget.item.price.toStringAsFixed(2)}",
                  style: context.body1?.copyWith(
                    color: context.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // ✅ Quantity Controls
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _circleButton(
                  context,
                  icon: Icons.remove,
                  onTap: () => CartController.to.decrease(widget.item),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.item.quantity.value.toString(),
                    style: context.h6?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _circleButton(
                  context,
                  icon: Icons.add,
                  onTap: () => CartController.to.increase(widget.item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Small rounded quantity buttons
  Widget _circleButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.kPrimaryColor.withValues(alpha: 0.1),
        ),
        child: Icon(icon, size: 18, color: context.kPrimaryColor),
      ),
    );
  }
}
