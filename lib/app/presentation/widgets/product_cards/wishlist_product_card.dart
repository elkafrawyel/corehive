import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/screens/product/product_details_screen.dart';
import 'package:corehive_store/app/presentation/screens/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/data/models/product_model.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../config/custome_navigation.dart';
import '../../screens/product/controller/product_details_controller.dart';

class WishlistProductCard extends StatelessWidget {
  final Product product;
  final String heroTag = UniqueKey().toString(); // 👈 random tag
  final String heroTagTitle = UniqueKey().toString(); // 👈 random tag

  WishlistProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: context.kCardBackgroundColor,

      onTap: () {
        navigateWithAnimation(
          context,
          ProductDetailsScreen(
            product: product,
            heroTag: heroTag,
            heroTagTitle: heroTagTitle,
          ),
        );
      },
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag,
            child: AppNetworkImage(
              imageUrl: product.imageUrl,
              width: 100,
              height: 100,
              radius: 12,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: heroTagTitle,
                  child: AppText(
                    text: product.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                AppText(
                  text: '\u0024${product.price}',
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
                if (product.rating != null)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      AppText(text: '${product.rating}', color: Colors.grey),
                    ],
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () async {
              final shouldRemove = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Remove from Wishlist'),
                  content: const Text(
                    'Are you sure you want to remove this product from your wishlist?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              );
              if (shouldRemove == true) {
                Get.find<WishlistController>().remove(product);
              }
            },
          ),
        ],
      ),
    );
  }
}
