import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:corehive_store/app/config/res.dart';
import 'package:corehive_store/app/presentation/screens/auth/controllers/auth_binding.dart';
import 'package:corehive_store/app/presentation/screens/auth/controllers/auth_controller.dart';
import 'package:corehive_store/app/presentation/screens/auth/register_screen.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_text_field/app_text_field.dart';
import '../../widgets/app_text_field/rules.dart';
import '../main/controllers/main_binding.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<AppTextFormFieldState> emailKey = GlobalKey();
  final GlobalKey<AppTextFormFieldState> passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: "Login",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- App Logo ---
            SizedBox(
              height: size.height * 0.15,
              child: Image.asset(
                Res.logo, // replace with your logo
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),

            // --- Welcome Message ---
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sign in to continue",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // --- Email Field ---
            AppTextFormField(
              key: emailKey,
              controller: emailController,
              hintText: "Email",
              appFieldType: AppFieldType.email,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // --- Password Field ---
            AppTextFormField(
              key: passwordKey,
              controller: passwordController,
              hintText: "Password",
              appFieldType: AppFieldType.password,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24),

            // --- Login Button ---
            AppButton(
              text: "Login",
              onPressed: () async {
                final isValid = AppTextFieldRules.validateForm([
                  emailKey,
                  passwordKey,
                ]);

                if (!isValid) return;

                Get.offAll(() => MainScreen(), binding: MainBinding());
              },
            ),
            const SizedBox(height: 16),

            // --- Register Link ---
            TextButton(
              onPressed: () {
                Get.to(() => RegisterScreen(), binding: AuthBinding());
              },
              child: const Text("Don't have an account? Register"),
            ),
            const SizedBox(height: 32),

            // --- Divider ---
            Row(
              children: const [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("OR", style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 24),

            // --- Social Login Buttons ---
            AppButton(
              text: "Continue with Google",
              icon: const FaIcon(
                FontAwesomeIcons.google,
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFFDB4437),
              textColor: Colors.white,
              onPressed: () => controller.signInWithGoogle(),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: "Continue with Apple",
              icon: const Icon(Icons.apple, size: 20, color: Colors.white),
              backgroundColor: Colors.black,
              textColor: Colors.white,
              onPressed: () => controller.signInWithApple(),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: "Continue with Facebook",
              icon: const FaIcon(
                FontAwesomeIcons.facebook,
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF1877F2),
              textColor: Colors.white,
              onPressed: () => controller.signInWithFacebook(),
            ),
          ],
        ),
      ),
    );
  }
}
