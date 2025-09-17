import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/home/components/product_card.dart';
import 'package:icons_plus/icons_plus.dart';

class RecommendationsSection extends StatelessWidget {
  const RecommendationsSection({super.key});

  final List<Map<String, dynamic>> recommendations = const [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      'title': 'iPhone 14 Pro Max',
      'price': '\$999',
      'originalPrice': '\$1,199',
      'rating': 4.8,
      'reviewCount': 1250,
      'isOnSale': true,
      'discountPercentage': 17,
      'reason': 'Based on your recent searches',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
      'title': 'Samsung Galaxy S23 Ultra',
      'price': '\$749',
      'originalPrice': '\$899',
      'rating': 4.6,
      'reviewCount': 980,
      'isOnSale': true,
      'discountPercentage': 17,
      'reason': 'Similar to your purchases',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1598327105666-5b89351aff97',
      'title': 'Google Pixel 7 Pro',
      'price': '\$699',
      'originalPrice': '\$899',
      'rating': 4.7,
      'reviewCount': 450,
      'isOnSale': true,
      'discountPercentage': 22,
      'reason': 'Trending in your area',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db',
      'title': 'Sony WH-1000XM4',
      'price': '\$299',
      'originalPrice': null,
      'rating': 4.5,
      'reviewCount': 320,
      'isOnSale': false,
      'discountPercentage': null,
      'reason': 'Perfect match for you',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1580910051074-3eb694886505',
      'title': 'OnePlus 11 Pro',
      'price': '\$599',
      'originalPrice': '\$699',
      'rating': 4.4,
      'reviewCount': 280,
      'isOnSale': true,
      'discountPercentage': 14,
      'reason': 'Based on your preferences',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.star_outline,
                color: context.kPrimaryColor,
                size: 20,
              ),
              8.pw,
              AppText(
                text: 'Recommended for You',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.kTextColor,
              ),
              const Spacer(),
              AppText(
                text: 'View All',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.kPrimaryColor,
              ),
            ],
          ),
          
          12.ph,
          
          SizedBox(
            height: 320,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommendations.length,
              separatorBuilder: (_, __) => 12.pw,
              itemBuilder: (context, index) {
                final product = recommendations[index];
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.65,
                  child: Column(
                    children: [
                      // Recommendation reason
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: context.kPrimaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AppText(
                          text: product['reason'],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: context.kPrimaryColor,
                          centerText: true,
                          maxLines: 1,
                        ),
                      ),
                      
                      8.ph,
                      
                      // Product card
                      Expanded(
                        child: ProductCard(
                          imageUrl: product['imageUrl'],
                          title: product['title'],
                          price: product['price'],
                          originalPrice: product['originalPrice'],
                          rating: product['rating'],
                          reviewCount: product['reviewCount'],
                          isOnSale: product['isOnSale'],
                          discountPercentage: product['discountPercentage'],
                          onTap: () {
                            // Navigate to product details
                          },
                          onWishlistTap: () {
                            // Toggle wishlist
                          },
                          onAddToCart: () {
                            // Add to cart
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
