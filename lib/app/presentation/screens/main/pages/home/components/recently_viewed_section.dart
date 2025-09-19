import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/home/components/product_card.dart';
import 'package:icons_plus/icons_plus.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({super.key});

  final List<Map<String, dynamic>> recentlyViewed = const [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      'title': 'iPhone 14 Pro Max',
      'price': '\$999',
      'originalPrice': '\$1,199',
      'rating': 4.8,
      'reviewCount': 1250,
      'isOnSale': true,
      'discountPercentage': 17,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
      'title': 'Samsung Galaxy S23 Ultra',
      'price': '\$749',
      'originalPrice': '\$899',
      'rating': 4.6,
      'reviewCount': 980,
      'isOnSale': true,
      'discountPercentage': 17,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1598327105666-5b89351aff97',
      'title': 'Google Pixel 7 Pro',
      'price': '\$699',
      'originalPrice': '\$899',
      'rating': 4.7,
      'reviewCount': 450,
      'isOnSale': true,
      'discountPercentage': 22,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1606813907291-d86efa9b94db',
      'title': 'Sony WH-1000XM4',
      'price': '\$299',
      'originalPrice': null,
      'rating': 4.5,
      'reviewCount': 320,
      'isOnSale': false,
      'discountPercentage': null,
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
                Iconsax.clock_outline,
                color: context.kPrimaryColor,
                size: 20,
              ),
              8.pw,
              AppText(
                text: 'Recently Viewed',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.kTextColor,
              ),
              const Spacer(),
              AppText(
                text: 'See All',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.kHintTextColor,
              ),
            ],
          ),

          12.ph,

          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.33,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyViewed.length,
              separatorBuilder: (_, __) => 12.pw,
              itemBuilder: (context, index) {
                final product = recentlyViewed[index];
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.42,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
