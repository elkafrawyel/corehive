import 'package:corehive_store/app/presentation/screens/shipping_address/controller/shipping_address_controller.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';

import '../../../../widgets/app_text.dart';
import 'components/cart_card.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: AppText(
          text: "My Cart",
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: context.kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.kTextColor),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.kBackgroundColor,
              context.kBackgroundColor.withValues(alpha: 0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Shipping Address Section
            Obx(() {
              if (cartController.items.isEmpty) {
                return const SizedBox.shrink();
              }
              final address =
                  Get.find<ShippingAddressController>().primaryAddress.value;
              return address == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: AppCard(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: context.kPrimaryColor,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  address.address,
                                  style: context.body1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }),
            // Cart Items List
            Expanded(
              child: Obx(() {
                if (cartController.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: context.kPrimaryColor.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your cart is empty',
                          style: context.h5?.copyWith(
                            color: context.kHintTextColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add items to your cart to see them here.',
                          style: context.body2?.copyWith(
                            color: context.kHintTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartController.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = cartController.items[index];
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 400),
                          builder: (context, value, child) {
                            return Opacity(opacity: value, child: child);
                          },
                          child: CartCard(item: item),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            // Checkout Section
            Obx(() {
              if (cartController.items.isEmpty) {
                return const SizedBox.shrink();
              }
              final address = cartController.selectedAddress.value;
              double shippingCost = address.isPrimary ? 15.0 : 25.0;
              return Container(
                margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Obx(
                          () => Text(
                            "\$${cartController.totalPrice.toStringAsFixed(2)}",
                            style: context.h4?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipping",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          "\$${shippingCost.toStringAsFixed(2)}",
                          style: context.h4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      text: "Checkout",
                      onPressed: () {
                        // Handle checkout
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
