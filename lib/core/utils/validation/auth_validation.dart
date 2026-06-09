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

  static String getEmailErrorMessage(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(email)) {
      return 'Invalid email format';
    }
    return '';
  }

  static String getResetCodeErrorMessage(String code) {
    if (code.isEmpty) {
      return 'Verification code is required';
    }
    if (!isValidResetCode(code)) {
      return 'Code must be 6 digits';
    }
    return '';
  }

  static String getOtpErrorMessage(String code) {
    if (code.isEmpty) {
      return 'OTP code is required';
    }
    if (!isValidOtpCode(code)) {
      return 'OTP code must be 6 digits';
    }
    return '';
  }

  static String getPasswordErrorMessage(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return '';
  }

  static String getPhoneErrorMessage(String phone) {
    if (phone.isEmpty) {
      return 'Phone number is required';
    }
    if (phone.length < 7) {
      return 'Invalid phone number';
    }
    return '';
  }

  static bool isValidPhone(String phone) {
    return phone.isNotEmpty && phone.length >= 7;
  }

  /// Validate Qatar phone number (8 digits, starting with 3-9)
  /// 
  /// Qatar phone numbers consist of 8 digits.
  /// The first digit must be between 3 and 9.
  /// Example: 30123456, 50987654, 77654321
  static bool isValidQatarPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 8) return false;
    final firstDigit = int.parse(cleaned[0]);
    return firstDigit >= 3 && firstDigit <= 9;
  }

  /// Get error message for invalid Qatar phone number
  /// 
  /// Returns appropriate error message based on validation failure reason.
  static String getQatarPhoneErrorMessage(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleaned.isEmpty) {
      return 'Phone number is required';
    }
    
    if (cleaned.length != 8) {
      return 'Phone number must be 8 digits';
    }
    
    final firstDigit = int.parse(cleaned[0]);
    if (firstDigit < 3 || firstDigit > 9) {
      return 'Phone number must start with a digit between 3 and 9';
    }
    
    return '';
  }
}
