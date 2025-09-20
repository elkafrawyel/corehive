import 'package:corehive_store/app/config/information_viewer.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/data/models/cart_model.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';

class FlashDealData {
  final String id;
  final String imageUrl;
  final String title;
  final String originalPrice;
  final String discountedPrice;
  final int discountPercentage;
  final DateTime endTime;
  final int stockLeft;

  FlashDealData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.endTime,
    required this.stockLeft,
  });
}

class FlashDealsSection extends StatefulWidget {
  const FlashDealsSection({super.key});

  @override
  State<FlashDealsSection> createState() => _FlashDealsSectionState();
}

class _FlashDealsSectionState extends State<FlashDealsSection> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<FlashDealData> deals = [
    FlashDealData(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      title: 'iPhone 14 Pro Max',
      originalPrice: '\$1,199',
      discountedPrice: '\$999',
      discountPercentage: 17,
      endTime: DateTime.now().add(const Duration(hours: 6, minutes: 30)),
      stockLeft: 12,
    ),
    FlashDealData(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
      title: 'Samsung Galaxy S23',
      originalPrice: '\$899',
      discountedPrice: '\$749',
      discountPercentage: 17,
      endTime: DateTime.now().add(const Duration(hours: 4, minutes: 15)),
      stockLeft: 8,
    ),
    FlashDealData(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97',
      title: 'Google Pixel 7 Pro',
      originalPrice: '\$899',
      discountedPrice: '\$699',
      discountPercentage: 22,
      endTime: DateTime.now().add(const Duration(hours: 8, minutes: 45)),
      stockLeft: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with countdown
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.kErrorColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  text: 'FLASH DEAL',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              8.pw,
              Expanded(
                child: AppText(
                  text:
                      'Ends in: ${_formatTimeRemaining(deals[_currentIndex].endTime)}',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: context.kErrorColor,
                ),
              ),
              AppText(
                text: 'View All',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.kPrimaryColor,
              ),
            ],
          ),

          12.ph,

          // Deals carousel
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _controller,
              itemCount: deals.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) =>
                  _buildDealCard(context, deals[index]),
            ),
          ),

          12.ph,

          // Page indicators
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                deals.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? context.kPrimaryColor
                        : context.kHintTextColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(BuildContext context, FlashDealData deal) {
    return AppCard(
      backgroundColor: Colors.white,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with discount badge
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.kTextFieldColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppNetworkImage(
                    imageUrl: deal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Discount badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.kErrorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppText(
                    text: '-${deal.discountPercentage}%',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Stock indicator
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppText(
                    text: '${deal.stockLeft} left',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          12.ph,

          // Product details
          AppText(
            text: deal.title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.kTextColor,
            maxLines: 2,
          ),

          8.ph,

          // Price section
          Row(
            children: [
              AppText(
                text: deal.discountedPrice,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.kPrimaryColor,
              ),
              8.pw,
              AppText(
                text: deal.originalPrice,
                fontSize: 14,
                color: context.kHintTextColor,
                lineThrough: true,
              ),
            ],
          ),

          12.ph,

          // Add to cart button
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'Add to Cart',
              fontSize: 14,
              backgroundColor: context.kPrimaryColor,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              onPressed: () {
                final cartController = Get.find<CartController>();
                final price =
                    double.tryParse(
                      deal.discountedPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
                    ) ??
                    0.0;
                final existing = cartController.items.firstWhereOrNull(
                  (item) => item.productName == deal.title,
                );
                if (existing != null) {
                  existing.quantity.value++;
                } else {
                  cartController.addItem(
                    CartModel(
                      id: 'CART-FLASH-${deal.id}',
                      productName: deal.title,
                      productImage: deal.imageUrl,
                      quantity: 1,
                      price: price,
                      shippingCost: 15.0,
                    ),
                  );
                }
                InformationViewer.showSuccessToast(msg: 'Added to cart!');
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeRemaining(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
