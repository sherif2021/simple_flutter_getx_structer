import 'package:get/get_utils/get_utils.dart';

class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 2) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? phoneValidator(String countryCode, String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone';
    } else if (!'${countryCode.trim()}${value.trim()}'.isPhoneNumber) {
      return 'Please enter a valid phone';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    } else if (value.length > 24) {
      return 'Password must be at less 24 characters';
    }
    return null;
  }
}
