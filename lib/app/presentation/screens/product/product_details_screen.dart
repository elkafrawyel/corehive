import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/screens/product/components/image_slider_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import 'controller/product_details_controller.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_button.dart';
import 'components/image_indicators_section.dart';
import 'components/price_section.dart';
import 'components/quantity_selector_section.dart';
import 'components/description_section.dart';
import 'components/buyer_section.dart';
import 'components/properties_section.dart';
import 'components/reviews_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String? heroTag; // 👈 new field
  final String? heroTagTitle; // 👈 new field
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.heroTag,
    this.heroTagTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(
        productId: productId,
        productRepo: Get.find(),
      ),
      builder: (productDetailsController) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: context.kColorOnPrimary),
          actions: [
            IconButton(
              icon: Icon(
                ProductDetailsController.to.product?.isWishlisted ?? false
                    ? Icons.favorite
                    : Icons.favorite_border,
                color:
                    ProductDetailsController.to.product?.isWishlisted ?? false
                    ? Colors.red
                    : context.kColorOnPrimary,
                size: 24,
              ),
              onPressed: ProductDetailsController.to.toggleWishlist,
            ),
          ],
        ),
        body: productDetailsController.product == null
            ? Center(child: AppText(text: 'Failed to load product info'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image slider and indicators below AppBar
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ImageSliderSection(
                          product: productDetailsController.product!,
                          heroTag: heroTag,
                        ),
                        ImageIndicatorsSection(
                          product: productDetailsController.product!,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PriceSection(
                            product: productDetailsController.product!,
                            heroTagTitle: heroTagTitle,
                          ),
                          const SizedBox(height: 8),
                          if (productDetailsController.product!.rating != null)
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                AppText(
                                  text:
                                      '${productDetailsController.product!.rating}',
                                  color: Colors.grey,
                                ),
                                AppText(
                                  text:
                                      ' (${productDetailsController.product!.reviewCount} reviews)',
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          const SizedBox(height: 16),
                          QuantitySelectorSection(),
                          const SizedBox(height: 16),
                          AppButton(
                            text: 'Add to Cart',
                            onPressed:
                                productDetailsController.addToCartWithQuantity,
                          ),
                          const SizedBox(height: 24),
                          DescriptionSection(
                            product: productDetailsController.product!,
                          ),
                          const SizedBox(height: 16),
                          BuyerSection(
                            product: productDetailsController.product!,
                          ),
                          const SizedBox(height: 24),
                          PropertiesSection(
                            product: productDetailsController.product!,
                          ),
                          const SizedBox(height: 24),
                          ReviewsSection(
                            product: productDetailsController.product!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
