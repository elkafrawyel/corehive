import 'dart:io';
import 'package:corehive_store/app/presentation/screens/auth/controllers/auth_binding.dart';
import 'package:corehive_store/app/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/data/repositories/user_repository.dart';
import 'package:corehive_store/app/data/models/user_model.dart';
import 'package:corehive_store/app/presentation/widgets/app_image_picker_dialog.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  final UserRepository userRepository;
  ProfileController({required this.userRepository});

  RxBool isLoggedIn = false.obs;
  File? _profileImage;

  Future<void> pickProfileImage(BuildContext context) async {
    showAppImageDialog(
      context: context,
      onFilePicked: (image) {
        profileImage = image;
      },
    );
  }

  void saveProfile({
    required String name,
    required String email,
    required String phone,
    required BuildContext context,
  }) {
    updateProfile(name: name, email: email, phone: phone, image: profileImage);
    Navigator.pop(context);
  }

  void logout() async {
    await userRepository.removeUser();
    userModel.value = null;
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen(), binding: AuthBinding());
  }

  File? get profileImage => _profileImage;
  set profileImage(File? image) {
    _profileImage = image;
    update();
  }

  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserModel();
  }

  void loadUserModel() {
    final user = userRepository.getUser();
    if (user != null) {
      userModel.value = user;
      isLoggedIn.value = true;
    }
  }

  void saveUserModel(UserModel user) async {
    await userRepository.saveUser(user);
    userModel.value = user;
  }

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    File? image,
  }) {
    final current = userModel.value;
    if (current != null) {
      String? imagePath;
      if (image != null) {
        imagePath = image.path;
      } else {
        imagePath = current.image;
      }
      final updated = UserModel(
        id: current.id,
        name: name ?? current.name,
        email: email ?? current.email,
        phone: phone ?? current.phone,
        image: imagePath,
      );
      saveUserModel(updated);
    }
  }
}
