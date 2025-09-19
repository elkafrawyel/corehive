import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/screens/categories_details/category_details_screen.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// Removed old CategoryData class, now using _Category for grid

class HomeCategories extends StatefulWidget {
  HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  final Map<String, List<String>> subCategoriesMap = const {
    'Electronics': [
      'Phones',
      'Laptops',
      'Cameras',
      'Audio',
      'Wearables',
      'Accessories',
    ],
    'Clothing': ['Men', 'Women', 'Kids', 'Shoes', 'Accessories'],
    'Home & Kitchen': [
      'Furniture',
      'Appliances',
      'Cookware',
      'Decor',
      'Storage',
    ],
    'Beauty': ['Makeup', 'Skincare', 'Haircare', 'Fragrance', 'Tools'],
    'Books': ['Fiction', 'Non-Fiction', 'Children', 'Comics', 'Textbooks'],
    'Sports': ['Fitness', 'Outdoor', 'Team Sports', 'Equipment', 'Footwear'],
    'Toys & Games': [
      'Educational',
      'Board Games',
      'Action Figures',
      'Puzzles',
      'Outdoor Toys',
    ],
    'Health & Personal Care': [
      'Supplements',
      'Medical',
      'Personal Hygiene',
      'Wellness',
      'Devices',
    ],
    'Automotive': ['Car Care', 'Accessories', 'Tools', 'Parts', 'Motorcycles'],
    'Pet Supplies': ['Food', 'Toys', 'Grooming', 'Beds', 'Health'],
  };
  final List<_Category> categories = const [
    _Category(
      name: 'Electronics',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
    ),
    _Category(
      name: 'Clothing',
      imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
    ),
    _Category(
      name: 'Home & Kitchen',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    ),
    _Category(
      name: 'Beauty',
      imageUrl: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2',
    ),
    _Category(
      name: 'Books',
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    ),
    _Category(
      name: 'Sports',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    ),
    _Category(
      name: 'Toys & Games',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    ),
    _Category(
      name: 'Health & Personal Care',
      imageUrl: 'https://images.unsplash.com/photo-1504198453319-5ce911bafcde',
    ),
    _Category(
      name: 'Automotive',
      imageUrl: 'https://images.unsplash.com/photo-1511918984145-48de785d4c4e',
    ),
    _Category(
      name: 'Pet Supplies',
      imageUrl: 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              final subCats = subCategoriesMap[category.name] ?? [];
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CategoryDetailsScreen(
                  categoryName: category.name,
                  subCategories: subCats,
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppNetworkImage(
                  imageUrl: category.imageUrl,
                  width: 60,
                  height: 60,
                  radius: 30,
                  isCircular: true,
                ),
                const SizedBox(height: 8),
                AppText(
                  text: category.name,
                  fontWeight: FontWeight.w600,
                  color: context.kTextColor,
                  fontSize: 13,
                  centerText: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Category {
  final String name;
  final String imageUrl;

  const _Category({required this.name, required this.imageUrl});
}
