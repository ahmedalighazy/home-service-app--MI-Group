

class AuthValidation {
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidResetCode(String code) {
    if (code.isEmpty) return false;
    return code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code);
  }

  static bool isValidOtpCode(String code) {
    if (code.isEmpty) return false;
    return code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code);
  }

  static bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword && password.isNotEmpty;
  }

  // static String getEmailErrorMessage(String email) {
  //   if (email.isEmpty) {
  //     return AuthStrings.emailRequired;
  //   }
  //   if (!isValidEmail(email)) {
  //     return AuthStrings.invalidEmail;
  //   }
  //   return '';
  // }

  // static String getResetCodeErrorMessage(String code) {
  //   if (code.isEmpty) {
  //     return AuthStrings.otpRequired;
  //   }
  //   if (!isValidResetCode(code)) {
  //     return AuthStrings.otpInvalid;
  //   }
  //   return '';
  // }

  // static String getOtpErrorMessage(String code) {
  //   if (code.isEmpty) {
  //     return AuthStrings.otpRequired;
  //   }
  //   if (!isValidOtpCode(code)) {
  //     return AuthStrings.otpInvalid;
  //   }
  //   return '';
  // }

  // static String getPasswordErrorMessage(String password) {
  //   if (password.isEmpty) {
  //     return AuthStrings.passwordRequired;
  //   }
  //   if (password.length < 6) {
  //     return AuthStrings.passwordMinLength6;
  //   }
  //   return '';
  // }

  // static String getPhoneErrorMessage(String phone) {
  //   if (phone.isEmpty) {
  //     return AuthStrings.phoneRequired;
  //   }
  //   if (phone.length < 7) {
  //     return AuthStrings.phoneInvalid;
  //   }
  //   return '';
  // }

  static bool isValidPhone(String phone) {
    return phone.isNotEmpty && phone.length >= 7;
  }

  static bool isValidQatarPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 8) return false;
    final firstDigit = int.parse(cleaned[0]);
    return firstDigit >= 3 && firstDigit <= 9;
  }

  // static String getQatarPhoneErrorMessage(String phone) {
  //   final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');

  //   if (cleaned.isEmpty) {
  //     return AuthStrings.phoneRequired;
  //   }

  //   if (cleaned.length != 8) {
  //     return AuthStrings.phoneLengthError;
  //   }

  //   final firstDigit = int.parse(cleaned[0]);
  //   if (firstDigit < 3 || firstDigit > 9) {
  //     return AuthStrings.phoneStartDigitError;
  //   }

  //   return '';
  // }
}
