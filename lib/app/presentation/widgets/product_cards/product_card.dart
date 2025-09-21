import 'package:corehive_store/app/presentation/screens/product/controller/product_details_controller.dart';
import 'package:corehive_store/app/presentation/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../config/custome_navigation.dart';
import '../../../data/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isInHorizontalList;

  const ProductCard({
    super.key,
    required this.product,
    this.isInHorizontalList = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final String heroTag = UniqueKey().toString(); // 👈 random tag
  final String heroTagTitle = UniqueKey().toString(); // 👈 random tag

  @override
  Widget build(BuildContext context) {
    final iconColor = context.kPrimaryColor;
    final product = widget.product;
    return SizedBox(
      width: widget.isInHorizontalList ? 150 : double.infinity,
      child: AppCard(
        backgroundColor: context.kCardBackgroundColor,
        padding: const EdgeInsets.all(8),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: heroTag,
                  child: AppNetworkImage(
                    height: widget.isInHorizontalList ? 130 : 200,
                    width: widget.isInHorizontalList ? 130 : double.infinity,
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    radius: 12,
                  ),
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
                        fontSize: 12,
                        color: context.kColorOnPrimary,
                      ),
                    ),
                  ),
              ],
            ),
            8.ph,
            // Title
            Hero(
              tag: heroTagTitle,
              child: AppText(
                text: product.title,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: context.kTextColor,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
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
