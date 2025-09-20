import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';

import '../../../../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onAddToCart;
  final bool isInHorizontalList;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onWishlistTap,
    this.onAddToCart,
    this.isInHorizontalList = false,
  });

  @override
  Widget build(BuildContext context) {
    // unified icon color
    final iconColor = context.kPrimaryColor;

    return SizedBox(
      width: isInHorizontalList ? 140 : double.infinity,
      child: AppCard(
        backgroundColor: Colors.white,
        borderColor: Colors.transparent,
        padding: const EdgeInsets.all(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bigger image with smaller buttons
            Stack(
              children: [
                AppNetworkImage(
                  height: 120,
                  width: isInHorizontalList ? 120 : double.infinity,
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  radius: 12,
                ),
                if (product.isOnSale && product.discountPercentage != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.kErrorColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: AppText(
                        text: '-${product.discountPercentage}%',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            8.ph,
            // Title
            AppText(
              text: product.title,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: context.kTextColor,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            4.ph,
            // Rating
            if (product.rating != null && product.reviewCount != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: iconColor, size: 12),
                  4.pw,
                  AppText(
                    text: product.rating.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: context.kTextColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.pw,
                  Flexible(
                    fit: FlexFit.loose,
                    child: AppText(
                      text: '(${product.reviewCount})',
                      fontSize: 10,
                      color: context.kHintTextColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            8.ph,
            // Price
            Row(
              children: [
                AppText(
                  text: product.price,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                  overflow: TextOverflow.ellipsis,
                ),
                if (product.originalPrice != null) ...[
                  8.pw,
                  AppText(
                    text: product.originalPrice!,
                    fontSize: 12,
                    color: context.kHintTextColor,
                    lineThrough: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
