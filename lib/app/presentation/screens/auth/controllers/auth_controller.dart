import 'package:get/get.dart';
import 'package:corehive_store/app/config/app_loader.dart';
import '../../../../config/information_viewer.dart';
import '../../../../data/api_requests/register_request.dart';
import '../../../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  var isLoading = false.obs;
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    isLoading.value = true;

    final result = await repository.register(
      registerRequest: RegisterRequest(
        name: name,
        email: email,
        phone: phone,
        password: password,
      ),
    );

    result.when(
      success: (data) {
        InformationViewer.showSuccessToast(
          msg: 'Account created successfully!',
        );
        // Get.offAll(() => const HomeScreen());
      },
      failure: (error, data) => InformationViewer.showErrorToast(msg: error),
      start: () {},
      loading: () {
        AppLoader.loading();
      },
      empty: (String message) {},
    );

    isLoading.value = false;
  }

  void signInWithGoogle() {
    InformationViewer.showSuccessToast(msg: 'Google Sign-In not implemented yet.');
  }

  void signInWithApple() {
    InformationViewer.showSuccessToast(msg: 'Apple Sign-In not implemented yet.');
  }

  void signInWithFacebook() {
    InformationViewer.showSuccessToast(msg: 'Facebook Sign-In not implemented yet.');
  }
}
