import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/config/information_viewer.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/data/models/product_model.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/data/models/cart_model.dart';

import '../../../widgets/app_card.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_button.dart';

class SearchProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  const SearchProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AppCard(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppNetworkImage(
                imageUrl: product.imageUrl,
                width: 120,
                height: 120,
                radius: 8,
              ),
            ),
            16.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: product.title,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  AppText(
                    text: '\u0024${product.price}',
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  if (product.rating != null)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        AppText(
                          text: '${product.rating}',
                          color: context.kHintTextColor,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton(
                      text: 'Add To Cart',
                      icon: Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                        color: context.kColorOnPrimary,
                      ),
                      backgroundColor: context.kPrimaryColor,
                      textColor: context.kColorOnPrimary,
                      fontSize: 15,
                      fullWidth: false,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      onPressed: () {
                        final cartController = Get.find<CartController>();
                        cartController.addItem(
                          CartModel(
                            id: product.id,
                            productName: product.title,
                            productImage: product.imageUrl,
                            quantity: 1,
                            price: double.tryParse(product.price) ?? 0,
                            shippingCost: 0,
                          ),
                        );
                        InformationViewer.showSuccessToast(
                          msg: 'Added to cart successfully',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
