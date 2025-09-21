import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/clients/storage/storage_client.dart';
import 'package:oktoast/oktoast.dart';
import 'app/config/theme/theme_controller.dart';
import 'app/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StorageClient.instance.init();
  runApp(CoreHiveStoreApp());
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

class CoreHiveStoreApp extends StatelessWidget {
  CoreHiveStoreApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return OKToast(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "CoreHiveStore App",
          theme: themeController.currentTheme.value,
          home: const SplashScreen(),
          builder: (context, child) {
            child = EasyLoading.init()(context, child);
            EasyLoading.instance
              ..displayDuration = const Duration(milliseconds: 2000)
              ..indicatorType = EasyLoadingIndicatorType.fadingCircle
              ..loadingStyle = EasyLoadingStyle.custom
              ..maskType = EasyLoadingMaskType.black
              ..indicatorSize = 50.0
              ..radius = 10.0
              ..progressWidth = 3
              ..progressColor = context.kPrimaryColor
              ..textColor = context.kTextColor
              ..backgroundColor = context.kBackgroundColor
              ..indicatorColor = context.kPrimaryColor
              // ..maskColor = Colors.blue.withOpacity(0.5)
              ..textStyle = const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )
              ..userInteractions = false
              ..dismissOnTap = false;
            child = MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child,
            );
            return child;
          },
        ),
      );
    });
  }
}
