import 'package:flutter/material.dart';

import 'components/home_banner.dart';
import 'components/home_categories.dart';
import 'components/home_header.dart';
import 'components/product_card.dart';
import 'components/section_title.dart';

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
              const HomeBanner(),
              const SizedBox(height: 16),
              const SectionTitle(title: "Categories"),
              const HomeCategories(),
              const SizedBox(height: 16),
              const SectionTitle(title: "New Arrivals"),
              _buildGridProducts(),
              const SectionTitle(title: "Best Sellers"),
              _buildHorizontalProducts(),
            ],
          ),
        ),
      ),
    );
  }

  final List<ProductCard> demoProducts = const [
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
      title: "iPhone X",
      price: "\$699.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3",
      title: "Samsung Galaxy S10",
      price: "\$599.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1598327105666-5b89351aff97",
      title: "Google Pixel 5",
      price: "\$649.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1606813907291-d86efa9b94db",
      title: "OnePlus 9 Pro",
      price: "\$729.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1580910051074-3eb694886505",
      title: "Huawei P40 Pro",
      price: "\$579.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1608379861370-f74790c380af",
      title: "Xiaomi Mi 11",
      price: "\$499.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1606813907291-d86efa9b94db",
      title: "Sony Xperia 5 II",
      price: "\$699.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1580910051074-3eb694886505",
      title: "Motorola Edge",
      price: "\$459.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1612036782180-6f3c1f0d5f74",
      title: "iPhone 13 Pro",
      price: "\$999.00",
    ),
    ProductCard(
      imageUrl: "https://images.unsplash.com/photo-1606813907291-d86efa9b94db",
      title: "Samsung Galaxy Z Flip",
      price: "\$1,199.00",
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
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => demoProducts[index],
      ),
    );
  }

  Widget _buildHorizontalProducts() {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: demoProducts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => demoProducts[index],
      ),
    );
  }
}
