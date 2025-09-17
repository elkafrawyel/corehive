import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';

class CategoryData {
  final String name;
  final IconData icon;
  final Color color;
  final int itemCount;

  CategoryData({
    required this.name,
    required this.icon,
    required this.color,
    this.itemCount = 0,
  });
}

class HomeCategories extends StatelessWidget {
  HomeCategories({super.key});

  final List<CategoryData> categories = [
    CategoryData(
      name: "Electronics",
      icon: Icons.phone_android,
      color: Color(0xFF4ECDC4),
      itemCount: 1250,
    ),
    CategoryData(
      name: "Fashion",
      icon: Icons.checkroom,
      color: Color(0xFFFF6B6B),
      itemCount: 890,
    ),

    CategoryData(
      name: "Sports",
      icon: Icons.sports_soccer,
      color: Color(0xFFFF9F43),
      itemCount: 420,
    ),
    CategoryData(
      name: "Beauty",
      icon: Icons.favorite,
      color: Color(0xFF9B59B6),
      itemCount: 380,
    ),
    CategoryData(
      name: "Books",
      icon: Icons.book,
      color: Color(0xFF2ECC71),
      itemCount: 1200,
    ),
    CategoryData(
      name: "Toys",
      icon: Icons.toys,
      color: Color(0xFFE74C3C),
      itemCount: 280,
    ),
    CategoryData(
      name: "More",
      icon: Icons.more_horiz,
      color: Color(0xFF95A5A6),
      itemCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Categories horizontal list
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => 12.pw,
              itemBuilder: (context, index) => _buildCategoryCard(context, categories[index]),
            ),
          ),
          
          16.ph,
          
          // View all categories button
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'View All Categories',
              onPressed: () {
                // Navigate to all categories
              },
              backgroundColor: context.kPrimaryColor,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              radius: 12,
              fontSize: 14,
              fullWidth: true,
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryData category) {
    return SizedBox(
      width: 80,
      child: AppCard(
        backgroundColor: Colors.white,
        borderColor: Colors.transparent,
        padding: const EdgeInsets.all(8),
        onTap: () {
          // Navigate to category
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: 20,
              ),
            ),
            
            6.ph,
            
            // Category name
            AppText(
              text: category.name,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: context.kTextColor,
              centerText: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Item count (if available)
            if (category.itemCount > 0) ...[
              2.ph,
              AppText(
                text: '${category.itemCount}+',
                fontSize: 8,
                color: context.kHintTextColor,
                centerText: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
