import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';

import 'controllers/nav_controller.dart';
import 'pages/cart/cart_page.dart';
import 'pages/categories/categories_view.dart';
import 'pages/home/home_page.dart';
import 'pages/profile/profile_view.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final screens = [
    const HomePage(),
    const CategoriesPage(),
    CartPage(),
      ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final NavController controller = Get.find();

    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: screens[controller.currentIndex.value],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: context.kBackgroundColor,
          height: 70,
          elevation: 1,
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          indicatorColor: context.kPrimaryColor.withValues(alpha: 0.5),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              selectedIcon: Icon(Icons.category),
              label: "Categories",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
