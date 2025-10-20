import 'package:corehive_store/app/data/repositories/auth_repository.dart';
import 'package:corehive_store/app/presentation/screens/main/controllers/main_binding.dart';
import 'package:corehive_store/app/presentation/screens/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/app_loader.dart';
import '../../../../config/information_viewer.dart';
import '../../../../data/api_requests/register_request.dart';
import 'package:corehive_store/app/data/repositories/user_repository.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthController({required this.authRepository, required this.userRepository});

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    AppLoader.loading();

    final result = await authRepository.register(
      registerRequest: RegisterRequest(
        name: name,
        email: email,
        phone: phone,
        password: password,
      ),
    );
    AppLoader.dismiss();

    if (result.isSuccess) {
      InformationViewer.showSuccessToast(msg: 'Register is successfully!');
      if (result.dataResult != null) {
        await userRepository.saveUser(result.dataResult!.data!);
        Get.offAll(() => MainScreen(), binding: MainBinding());
      }
    } else {
      InformationViewer.showErrorToast(msg: result.errorResult!);
    }
  }

  Future<void> login({required String email, required String password}) async {
    AppLoader.loading();
    final result = await authRepository.login(email: email, password: password);
    AppLoader.dismiss();
    if (result.isSuccess) {
      InformationViewer.showSuccessToast(msg: 'Logged in successfully!');
      if (result.dataResult != null) {
        await userRepository.saveUser(result.dataResult!.data!);
        Get.offAll(() => MainScreen(), binding: MainBinding());
      }
    } else {
      InformationViewer.showErrorToast(msg: result.errorResult!);
    }
  }

  Future<void> signInWithGoogle() async {}

  Future<void> signInWithApple() async {}
}
