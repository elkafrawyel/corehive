import 'package:corehive_store/app/presentation/screens/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_text.dart';
import '../../widgets/product_cards/wishlist_product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: 'My Wishlist',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<WishlistController>(
        init: WishlistController(productRepo: Get.find()),
        builder: (controller) {
          if (controller.wishlist.isEmpty) {
            return const Center(
              child: AppText(
                text: 'Your wishlist is empty.',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.wishlist.length,
            itemBuilder: (context, index) {
              final product = controller.wishlist[index];
              return WishlistProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
