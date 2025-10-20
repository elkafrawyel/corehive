import 'package:corehive_store/app/config/clients/storage/storage_client.dart';

class Res {
  static const String apiLogin = '/auth/login';
  static const String apiRegister = '/auth/register';
  static const String apiForgetPassword = '/auth/forget-password';
  static const String apiVerifyOtp = '/auth/verify-otp';
  static const String apiResetPassword = '/auth/reset-password';
  static const String apiVerifyAccount = '/auth/verify-account';

  static String logo() => StorageClient().isDarkMode()
      ? 'assets/images/logo_dark.png'
      : 'assets/images/logo.png';
  static const String avatarPlaceholder =
      'assets/images/avatar_placeholder.webp';
}
