import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:icons_plus/icons_plus.dart';

class BrandData {
  final String id;
  final String name;
  final String logoUrl;
  final int productCount;
  final double rating;
  final bool isVerified;

  BrandData({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.productCount,
    required this.rating,
    this.isVerified = false,
  });
}

class BrandsSection extends StatelessWidget {
  BrandsSection({super.key});

  final List<BrandData> brands = [
    BrandData(
      id: '1',
      name: 'Apple',
      logoUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      productCount: 1250,
      rating: 4.8,
      isVerified: true,
    ),
    BrandData(
      id: '2',
      name: 'Samsung',
      logoUrl: 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
      productCount: 980,
      rating: 4.6,
      isVerified: true,
    ),
    BrandData(
      id: '3',
      name: 'Google',
      logoUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97',
      productCount: 450,
      rating: 4.7,
      isVerified: true,
    ),
    BrandData(
      id: '4',
      name: 'Sony',
      logoUrl: 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db',
      productCount: 320,
      rating: 4.5,
      isVerified: true,
    ),
    BrandData(
      id: '5',
      name: 'OnePlus',
      logoUrl: 'https://images.unsplash.com/photo-1580910051074-3eb694886505',
      productCount: 280,
      rating: 4.4,
      isVerified: true,
    ),
    BrandData(
      id: '6',
      name: 'Xiaomi',
      logoUrl: 'https://images.unsplash.com/photo-1608379861370-f74790c380af',
      productCount: 650,
      rating: 4.3,
      isVerified: true,
    ),
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
              AppText(
                text: 'Popular Brands',
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
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              separatorBuilder: (_, __) => 12.pw,
              itemBuilder: (context, index) => _buildBrandCard(context, brands[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(BuildContext context, BrandData brand) {
    return SizedBox(
      width: 100,
      child: AppCard(
        backgroundColor: Colors.white,
        borderColor: Colors.transparent,
        padding: const EdgeInsets.all(12),
        onTap: () {
          // Navigate to brand page
        },
        child: Column(
          children: [
            // Brand logo
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: context.kTextFieldColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: AppNetworkImage(
                      imageUrl: brand.logoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Verified badge
                if (brand.isVerified)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: context.kPrimaryColor,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Iconsax.verify_outline,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
              ],
            ),
            
            8.ph,
            
            // Brand name
            AppText(
              text: brand.name,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: context.kTextColor,
              centerText: true,
              maxLines: 1,
            ),
            
            4.ph,
            
            // Rating and product count
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: context.kPrimaryColor,
                  size: 12,
                ),
                2.pw,
                AppText(
                  text: brand.rating.toString(),
                  fontSize: 10,
                  color: context.kHintTextColor,
                ),
              ],
            ),
            
            2.ph,
            
            AppText(
              text: '${brand.productCount} products',
              fontSize: 9,
              color: context.kHintTextColor,
              centerText: true,
            ),
          ],
        ),
      ),
    );
  }
}
