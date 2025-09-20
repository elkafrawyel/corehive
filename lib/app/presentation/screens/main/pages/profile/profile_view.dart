import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/profile_controller.dart';
import 'pages/profile_guest_page.dart';
import 'pages/profile_login_page.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        if (profileController.isLoggedIn.value) {
          return const ProfileLoggedInPage();
        } else {
          return const ProfileGuestPage();
        }
      },
    );
  }
}
