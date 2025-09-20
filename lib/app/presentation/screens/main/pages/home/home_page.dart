import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../widgets/app_text.dart';
import 'components/home_banner.dart';
import 'components/home_categories.dart';
import 'components/home_header.dart';
import 'components/horizontal_listview.dart';
import 'components/product_card.dart';
import 'components/section_title.dart';
import 'components/flash_deals_section.dart';
import 'components/quick_actions_section.dart';
import 'components/brands_section.dart';
import 'controller/home_controller.dart';

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
        child: GetBuilder<HomeController>(
          builder: (homeController) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const HomeHeader()),
                SliverToBoxAdapter(child: 16.ph),
                SliverToBoxAdapter(child: const HomeBanner()),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(
                  child: const SectionTitle(title: "Categories"),
                ),
                SliverToBoxAdapter(child: HomeCategories()),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(child: QuickActionsSection()),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(child: const FlashDealsSection()),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(
                  child: const SectionTitle(title: "Featured Products"),
                ),
                SliverToBoxAdapter(
                  child: HorizontalListView(
                    products: homeController.featuredProducts,
                  ),
                ),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(child: BrandsSection()),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
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
                  ),
                ),
                SliverToBoxAdapter(
                  child: HorizontalListView(
                    products: homeController.recentlyViewed,
                  ),
                ),
                SliverToBoxAdapter(child: 20.ph),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = homeController.products[index];
                      return ProductCard(product: product);
                    }, childCount: homeController.products.length),
                  ),
                ),
                SliverToBoxAdapter(child: 20.ph),
                SliverToBoxAdapter(
                  child: const SectionTitle(title: "Best Sellers"),
                ),
                SliverToBoxAdapter(
                  child: HorizontalListView(
                    products: homeController.bestSellers,
                  ),
                ),
                SliverToBoxAdapter(child: 20.ph),
              ],
            );
          },
        ),
      ),
    );
  }
}
