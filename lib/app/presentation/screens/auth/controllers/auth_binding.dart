import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register repository
    Get.lazyPut(() => AuthRepositoryImpl());

    // Register controller, depends on the repository
    Get.lazyPut<AuthController>(() => AuthController(repository: Get.find()));
  }
}
