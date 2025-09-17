import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/screens/auth/controllers/auth_binding.dart';
import 'package:corehive_store/app/presentation/screens/auth/login_screen.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';
import '../../../../../../config/res.dart';
import '../../../../../../config/theme/theme_controller.dart';
import '../../../../../widgets/app_network_image.dart';
import '../../../../../widgets/app_text.dart';
import '../components/profile_tile.dart';
import '../components/profile_tile_switch.dart';
import '../controller/profile_controller.dart';

class ProfileGuestPage extends StatelessWidget {
  const ProfileGuestPage({super.key});

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
              AppNetworkImage(
                imageUrl: null,
                width: 100,
                height: 100,
                isCircular: true,
                fallbackAsset: Res.avatarPlaceholder,
              ),
              const SizedBox(height: 16),
              AppText(
                text: 'Welcome, Guest!',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.kTextColor,
              ),
              AppText(
                text: 'Sign in to access your account',
                fontSize: 16,
                color: context.kHintTextColor,
              ),
              const SizedBox(height: 24),
              AppButton(
                onPressed: () {
                  Get.to(() => LoginScreen(), binding: AuthBinding());
                },
                text: "Sign In / Create Account",
              ),
              const SizedBox(height: 32),

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
            ],
          ),
        ),
      ),
    );
  }
}
