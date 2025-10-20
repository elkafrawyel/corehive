import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../config/clients/storage/storage_client.dart';
import '../../../config/helpers/regex.dart';
import 'app_text_field.dart';
import 'auth_form_rules.dart';

class AppTextFieldRules {
  static bool validateForm(List<GlobalKey<AppTextFormFieldState>> keys) {
    int errors = 0;
    for (final key in keys) {
      final validated = key.currentState?.validate(withFocus: false) ?? false;
      if (!validated) errors++;
    }
    return errors == 0;
  }

  /// Accepts valid email or Egyptian phone
  static final List<AuthFormRule> emailOrPhoneRules = [
    AuthFormRule(
      ruleText: StorageClient.instance.isAr()
          ? '.البريد الالكتروني أو رقم الهاتف غير صحيح'
          : 'Email address or phone number is not valid.',
      condition: (value) {
        return isEmail(value) || isPhone(value);
      },
    ),
  ];

  static final List<AuthFormRule> emailRules = [
    AuthFormRule(
      ruleText: StorageClient.instance.isAr()
          ? 'رجاء ادخال بريد إلكتروني صحيح'
          : 'Please enter a valid email format',
      condition: isEmail,
    ),
  ];

  static final List<AuthFormRule> phoneNumberRules = [
    AuthFormRule(
      ruleText: StorageClient.instance.isAr()
          ? 'رجاء أدخل رقم هاتف مصري صحيح'
          : 'Please enter a valid Egyptian phone number',
      condition: (value) => isPhone(value) && isEgyptianPhone(value),
    ),
  ];

  static final List<AuthFormRule> passwordRules = [
    AuthFormRule(
      ruleText: 'min_8_char'.tr,
      condition: (value) => value.length >= 8,
    ),
    AuthFormRule(
      ruleText: 'one_lower_letter'.tr,
      condition: (value) => RegExp(r'[a-z]+').hasMatch(value),
    ),
    AuthFormRule(
      ruleText: 'one_upper_letter'.tr,
      condition: (value) => RegExp(r'[A-Z]+').hasMatch(value),
    ),
    AuthFormRule(
      ruleText: "special_char".tr,
      condition: (value) => RegExp(r'[!@#_$&%^{}/|]+').hasMatch(value),
    ),
    AuthFormRule(
      ruleText: 'one_num'.tr,
      condition: (value) => RegExp(r'[0-9]+').hasMatch(value),
    ),
  ];
}
