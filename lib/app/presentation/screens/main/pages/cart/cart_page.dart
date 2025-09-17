import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/information_viewer.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';

import '../../../../../domain/entities/cart_model.dart';
import '../../../../widgets/app_text.dart';
import 'components/cart_card.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartPage({super.key}) {
    // Demo mobile items
    cartController.addItem(
      CartItem(
        title: "iPhone 15 Pro",
        imageUrl:
            "https://images.unsplash.com/photo-1607082349566-187342175e2f",
        price: 1199,
      ),
    );
    cartController.addItem(
      CartItem(
        title: "iPhone 14 Pro",
        imageUrl:
            "https://images.unsplash.com/photo-1522202176988-66273c2fd55f",
        price: 999,
      ),
    );
    cartController.addItem(
      CartItem(
        title: "iPhone 13",
        imageUrl:
            "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
        price: 799,
      ),
    );
    cartController.addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );

    cartController.addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );

    cartController.addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );

    cartController.addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "My Cart",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: context.kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.kTextColor),
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: cartController.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = cartController.items[index];
                  // Animate each item when built
                  return TweenAnimationBuilder<double>(
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
                  );
                },
              ),
            ),
          ),

          // Checkout Section
          Obx(
            () => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.kBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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

                  // Checkout Button
                  AppButton(
                    onPressed: () {
                      InformationViewer.showSnackBar(
                        msg: 'Proceeding to payment...',
                      );
                    },
                    text: "Checkout",
                    fullWidth: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
