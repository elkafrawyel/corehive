import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? originalPrice;
  final double? rating;
  final int? reviewCount;
  final bool isWishlisted;
  final bool isOnSale;
  final int? discountPercentage;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.isWishlisted = false,
    this.isOnSale = false,
    this.discountPercentage,
    this.onTap,
    this.onWishlistTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // unified icon color
    final iconColor = context.kPrimaryColor;

    return AppCard(
      backgroundColor: Colors.white,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.all(8),
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bigger image with smaller buttons
              Stack(
                children: [
                  Container(
                    height:
                        constraints.maxWidth * 0.9, // responsive image height
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: context.kTextFieldColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AppNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isOnSale && discountPercentage != null)
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
                          text: '-$discountPercentage%',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // Bottom buttons
                ],
              ),
              8.ph,
              // Title
              AppText(
                text: title,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: context.kTextColor,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              4.ph,
              // Rating
              if (rating != null && reviewCount != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: iconColor, size: 12),
                    4.pw,
                    Flexible(
                      fit: FlexFit.loose,
                      child: AppText(
                        text: rating.toString(),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: context.kTextColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    4.pw,
                    Flexible(
                      fit: FlexFit.loose,
                      child: AppText(
                        text: '($reviewCount)',
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
                  Flexible(
                    fit: FlexFit.loose,
                    child: AppText(
                      text: price,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (originalPrice != null) ...[
                    8.pw,
                    Flexible(
                      fit: FlexFit.loose,
                      child: AppText(
                        text: originalPrice!,
                        fontSize: 12,
                        color: context.kHintTextColor,
                        lineThrough: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
