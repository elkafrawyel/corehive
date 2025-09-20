import 'package:corehive_store/app/presentation/widgets/app_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/information_viewer.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';

import '../../../../widgets/app_text.dart';
import '../../../shipping_address/controller/shipping_address_controller.dart';
import '../../../shipping_address/shipping_address_screen.dart';
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
              final address = cartController.selectedAddress.value;
              return Padding(
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
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.name,
                                style: context.h6?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(address.address, style: context.body2),
                              Text(
                                address.phone,
                                style: context.body2?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ShippingAddressScreen(),
                              ),
                            );
                            // After returning, update selected address from controller
                            final controller = Get.find<CartController>();
                            final shippingController =
                                Get.find<ShippingAddressController>();
                            controller.selectedAddress.value =
                                shippingController.primaryAddress.value ??
                                controller.selectedAddress.value;
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(fontWeight: FontWeight.w600),
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
              child: Obx(
                () => ListView.separated(
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
                          duration: Duration(milliseconds: 400 + (index * 100)),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 50),
                                child: child,
                              ),
                            );
                          },
                          child: CartCard(item: item),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Checkout Section
            Obx(() {
              final address = cartController.selectedAddress.value;
              // Example: shipping cost based on address (could be more complex)
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
                        Text(
                          "\$${cartController.totalPrice.toStringAsFixed(2)}",
                          style: context.h4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.kPrimaryColor,
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
                          style: TextStyle(
                            color: context.kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Delivery to: ${address.name}, ${address.address}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    const SizedBox(height: 18),
                    AppButton(
                      onPressed: () {
                        InformationViewer.showSnackBar(
                          msg: 'Proceeding to payment...',
                        );
                      },
                      text: "Checkout",
                      fullWidth: true,
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
