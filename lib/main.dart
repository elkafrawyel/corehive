import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luma/app/config/clients/storage/storage_client.dart';
import 'package:oktoast/oktoast.dart';
import 'app/config/theme/theme_controller.dart';
import 'app/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageClient.instance.init();
  runApp(LumaApp());
}

class LumaApp extends StatelessWidget {
  LumaApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return OKToast(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Luma App",
          theme: themeController.currentTheme.value,
          home: const SplashScreen(),
        ),
      );
    });
  }
}
