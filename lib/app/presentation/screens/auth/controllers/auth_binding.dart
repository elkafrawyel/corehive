import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register repository
    Get.lazyPut(() => AuthRepository());

    // Register controller, depends on the repository
    Get.lazyPut<AuthController>(
      () => AuthController(
        authRepository: Get.find(),
        userRepository: Get.find(),
      ),
    );
  }
}
