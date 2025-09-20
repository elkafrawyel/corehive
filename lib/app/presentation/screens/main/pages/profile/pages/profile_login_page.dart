import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/theme/theme_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../../widgets/app_network_image.dart';
import '../../../../../widgets/app_text.dart';
import '../components/profile_tile.dart';
import '../components/profile_tile_switch.dart';
import '../controller/profile_controller.dart';
import '../../../../shipping_address/shipping_address_screen.dart';

class ProfileLoggedInPage extends StatelessWidget {
  const ProfileLoggedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: AppBar(
        title: AppText(
          text: 'Profile',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.kTextColor,
        ),
        backgroundColor: context.kBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // --- Profile Header ---
              AppNetworkImage(
                imageUrl: 'https://i.pravatar.cc/300',
                width: 100,
                height: 100,
                isCircular: true,
              ),
              const SizedBox(height: 16),
              AppText(
                text: 'John Doe',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.kTextColor,
              ),
              AppText(
                text: 'johndoe@email.com',
                fontSize: 16,
                color: context.kHintTextColor,
              ),
              const SizedBox(height: 32),

              // --- Shipping Address Tile ---
              ProfileTile(
                icon: Icons.location_on,
                title: "Shipping Address",
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ShippingAddressScreen(),
                    withNavBar: true,
                  );
                },
              ),

              // --- Profile Tiles ---
              ProfileTile(
                icon: Icons.language,
                title: "Change Language",
                onTap: () {},
              ),
              // Interactive Tiles
              Obx(
                () => ProfileTileToggle(
                  icon: Icons.dark_mode,
                  title: "Theme",
                  value: ThemeController.to.isDarkMode.value,
                  onChanged: (val) => ThemeController.to.toggleAppTheme(),
                ),
              ),

              ProfileTile(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: () {},
              ),
              ProfileTile(
                icon: Icons.description,
                title: "Terms & Conditions",
                onTap: () {},
              ),
              ProfileTile(
                icon: Icons.contact_mail,
                title: "Contact Us",
                onTap: () {},
              ),

              const Divider(height: 40),

              // --- Logout ---
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: AppText(
                  text: 'Logout',
                  color: context.kErrorColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  Get.find<ProfileController>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
