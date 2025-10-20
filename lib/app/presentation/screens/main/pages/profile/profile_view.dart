import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/profile_controller.dart';
import 'pages/profile_guest_page.dart';
import 'pages/profile_login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      if (profileController.isLoggedIn.value) {
        return const ProfileLoggedInPage();
      } else {
        return const ProfileGuestPage();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
