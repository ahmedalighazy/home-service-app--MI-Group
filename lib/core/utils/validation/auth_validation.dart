class AuthValidation {
  // Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate phone number (Qatar format: +974 followed by 8 digits starting with 3-9)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 8) {
      return 'Phone number must be 8 digits';
    }
    if (cleaned[0].compareTo('3') < 0 || cleaned[0].compareTo('9') > 0) {
      return 'Invalid phone number format';
    }
    return null;
  }

  // Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Validate confirm password matches
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Validate name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Validate OTP code
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }

  // Validate reset code
  static String? validateResetCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Reset code is required';
    }
    if (value.length != 4) {
      return 'Reset code must be 4 digits';
    }
    return null;
  }

  // Boolean validation methods
  static bool isValidEmail(String? value) {
    return validateEmail(value) == null;
  }

  static bool isValidResetCode(String? value) {
    return validateResetCode(value) == null;
  }

  static bool isValidPassword(String? value) {
    return validatePassword(value) == null;
  }

  static bool passwordsMatch(String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) return false;
    return password == confirmPassword;
  }

  static bool isValidOtpCode(String? value) {
    return validateOtp(value) == null;
  }

  // Error message methods
  static String getEmailErrorMessage(String? value) {
    return validateEmail(value) ?? '';
  }

  static String getResetCodeErrorMessage(String? value) {
    return validateResetCode(value) ?? '';
  }

  static String getOtpErrorMessage(String? value) {
    return validateOtp(value) ?? '';
  }

  static String getPasswordErrorMessage(String? value) {
    return validatePassword(value) ?? '';
  }
}
