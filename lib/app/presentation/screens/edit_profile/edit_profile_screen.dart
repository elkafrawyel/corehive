import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_image_picker_dialog.dart';
import '../../widgets/app_text_field/app_text_field.dart';
import '../main/pages/profile/controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final profile = ProfileController.to;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: profile.userModel.value?.name,
    );
    _emailController = TextEditingController(
      text: profile.userModel.value?.email,
    );
    _phoneController = TextEditingController(
      text: profile.userModel.value?.phone,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _pickImage() {
    profile.pickProfileImage(context);
  }

  void _saveProfile() {
    profile.saveProfile(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: GetBuilder<ProfileController>(
                builder: (profile) => CircleAvatar(
                  radius: 50,
                  backgroundImage: profile.profileImage != null
                      ? FileImage(profile.profileImage!)
                      : (profile.userModel.value?.image != null
                                ? NetworkImage(profile.userModel.value!.image!)
                                : null)
                            as ImageProvider?,
                  child:
                      profile.profileImage == null &&
                          profile.userModel.value?.image == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppTextFormField(controller: _nameController, labelText: 'Name'),
            const SizedBox(height: 16),
            AppTextFormField(
              controller: _emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              controller: _phoneController,
              labelText: 'Phone',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            AppButton(text: 'Save', onPressed: _saveProfile),
          ],
        ),
      ),
    );
  }
}
