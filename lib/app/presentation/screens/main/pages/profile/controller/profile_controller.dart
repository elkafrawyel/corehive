import 'package:get/get.dart';

class ProfileController extends GetxController{

  RxBool isLoggedIn = true.obs;

  void login() => isLoggedIn.value = true;
  void logout() => isLoggedIn.value = false;
}