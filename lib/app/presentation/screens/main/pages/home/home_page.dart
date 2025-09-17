import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';

import 'components/home_banner.dart';
import 'components/home_categories.dart';
import 'components/home_header.dart';
import 'components/product_card.dart';
import 'components/section_title.dart';
import 'components/flash_deals_section.dart';
import 'components/quick_actions_section.dart';
import 'components/brands_section.dart';
import 'components/recently_viewed_section.dart';
import 'components/recommendations_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 👈 ensures the widget is kept alive

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),

              16.ph,

              const HomeBanner(),

              20.ph,

              const SectionTitle(title: "Categories"),
              HomeCategories(),

              20.ph,

              QuickActionsSection(),

              20.ph,

              const FlashDealsSection(),

              20.ph,

              const SectionTitle(title: "Featured Products"),
              _buildHorizontalProducts(),

              20.ph,

              BrandsSection(),

              20.ph,

              const RecommendationsSection(),

              20.ph,

              const RecentlyViewedSection(),

              20.ph,

              _buildGridProducts(),

              20.ph,

              const SectionTitle(title: "Best Sellers"),
              _buildHorizontalProducts(),

              20.ph,
            ],
          ),
        ),
      ),
    );
  }

  final List<ProductCard> demoProducts = const [
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
      title: "iPhone 14 Pro Max",
      price: "\$999",
      originalPrice: "\$1,199",
      rating: 4.8,
      reviewCount: 1250,
      isOnSale: true,
      discountPercentage: 17,
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3",
      title: "Samsung Galaxy S23 Ultra",
      price: "\$749",
      originalPrice: "\$899",
      rating: 4.6,
      reviewCount: 980,
      isOnSale: true,
      discountPercentage: 17,
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1598327105666-5b89351aff97",
      title: "Google Pixel 7 Pro ",
      price: "\$699",
      originalPrice: "\$899",
      rating: 4.7,
      reviewCount: 450,
      isOnSale: true,
      discountPercentage: 22,
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1606813907291-d86efa9b94db",
      title: "Sony WH-1000XM4",
      price: "\$299",
      rating: 4.5,
      reviewCount: 320,
      isOnSale: false,
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1580910051074-3eb694886505",
      title: "OnePlus 11 Pro",
      price: "\$599",
      originalPrice: "\$699",
      rating: 4.4,
      reviewCount: 280,
      isOnSale: true,
      discountPercentage: 14,
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1608379861370-f74790c380af",
      title: "Xiaomi Mi 13 Pro ",
      price: "\$499",
      originalPrice: "\$599",
      rating: 4.3,
      reviewCount: 180,
      isOnSale: true,
      discountPercentage: 17,
    ),
  ];

  Widget _buildGridProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: demoProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => demoProducts[index],
      ),
    );
  }

  Widget _buildHorizontalProducts() {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width * 0.42;
    final listHeight =
        cardWidth *
        1.75; // slightly reduce to prevent overflow with 2-line titles
    return SizedBox(
      height: listHeight.clamp(220.0, 300.0),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: demoProducts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => SizedBox(
          width: cardWidth.clamp(150.0, 200.0),
          child: demoProducts[index],
        ),
      ),
    );
  }
}
