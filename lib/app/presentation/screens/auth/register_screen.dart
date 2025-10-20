import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field/app_text_field.dart';
import '../../widgets/app_text_field/rules.dart';
import 'controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController controller = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<AppTextFormFieldState> nameKey = GlobalKey();
  final GlobalKey<AppTextFormFieldState> emailKey = GlobalKey();
  final GlobalKey<AppTextFormFieldState> phoneKey = GlobalKey();
  final GlobalKey<AppTextFormFieldState> passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextFormField(
              key: nameKey,
              controller: nameController,
              hintText: "Full Name",
              appFieldType: AppFieldType.name,
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              key: emailKey,
              controller: emailController,
              hintText: "Email",
              appFieldType: AppFieldType.email,
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              key: phoneKey,
              controller: phoneController,
              hintText: "Phone",
              appFieldType: AppFieldType.phone,
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              key: passwordKey,
              controller: passwordController,
              hintText: "Password",
              appFieldType: AppFieldType.password,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: "Register",
              onPressed: () async {
                final isValid = AppTextFieldRules.validateForm([
                  nameKey,
                  emailKey,
                  phoneKey,
                  passwordKey,
                ]);

                if (!isValid) return;

                controller.register(
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  password: passwordController.text,
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
