import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'controllers/nav_controller.dart';
import 'pages/cart/cart_page.dart';
import 'pages/cart/controller/cart_controller.dart';
import 'pages/orders/orders_page.dart';
import 'pages/home/home_page.dart';
import 'pages/profile/profile_view.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final screens = [
    const HomePage(),
    const OrdersPage(),
    CartPage(),
    ProfilePage(),
  ];

  final NavController navController = Get.find<NavController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PersistentTabView(
        context,
        controller: navController.tabController,
        screens: screens,
        backgroundColor: context.kBackgroundColor,
        items: [
          PersistentBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.house),
            iconSize: 20,
            title: "Home",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Theme.of(context).hintColor,
          ),
          PersistentBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.list),
            iconSize: 20,
            title: "Orders",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Theme.of(context).hintColor,
          ),
          PersistentBottomNavBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const FaIcon(FontAwesomeIcons.cartShopping),
                if (cartController.items.isNotEmpty)
                  PositionedDirectional(
                    end: -10,
                    top: -10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        cartController.items.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            iconSize: 20,
            title: "Cart",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Theme.of(context).hintColor,
          ),
          PersistentBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.user),
            iconSize: 20,
            title: "Profile",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Theme.of(context).hintColor,
          ),
        ],
        navBarStyle: NavBarStyle.style3,
        onItemSelected: (index) {
          navController.changeTab(index);
        },
      ),
    );
  }
}
