import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:corehive_store/app/presentation/screens/main/controllers/main_binding.dart';
import 'package:corehive_store/app/presentation/screens/main/main_screen.dart';
import 'package:corehive_store/app/config/res.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (Get.context != null) {
        Get.off(() => MainScreen(), binding: MainBinding());
      }
    });

    return Scaffold(
      body: Center(
        child: Image.asset(Res.logo, width: 150, height: 150)
            .animate()
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.2, 1.2),
              duration: 1500.ms,
              curve: Curves.easeInOut,
            )
            .move(
              begin: const Offset(0, 50),
              end: Offset.zero,
              duration: 1500.ms,
              curve: Curves.easeOut,
            )
            .fade(begin: 0.0, end: 1.0, duration: 1500.ms, curve: Curves.easeIn)
            .then(delay: 500.ms)
            .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1.0, 1.0),
              duration: 800.ms,
              curve: Curves.easeOutBack,
            ),
      ),
    );
  }
}
