import 'package:home_service_app/core/utils/validation/validation_constants.dart';

/// Advanced Validation Helper Class
/// 
/// Provides comprehensive validation methods with input sanitization
/// and security checks for all form fields
class ValidatorsHelper {
  ValidatorsHelper._();

  // ════════════════════════════════════════════════════════════════
  // INPUT SANITIZATION
  // ════════════════════════════════════════════════════════════════

  /// Remove leading and trailing whitespace
  static String trim(String? value) {
    return value?.trim() ?? '';
  }

  /// Normalize whitespace (remove extra spaces, tabs, newlines)
  static String normalizeWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Normalize unicode characters (NFKC normalization)
  static String normalizeUnicode(String value) {
    // Flutter doesn't have built-in unicode normalization
    // This is a basic implementation
    return value.trim();
  }

  /// Check for XSS/injection attempts
  static bool isXSSAttempt(String value) {
    final xssRegex = RegExp(ValidationConstants.xssPattern, caseSensitive: false);
    return xssRegex.hasMatch(value);
  }

  /// Check for SQL injection patterns
  static bool isSQLInjectionAttempt(String value) {
    final sqlRegex = RegExp(ValidationConstants.sqlInjectionPattern);
    return sqlRegex.hasMatch(value);
  }

  /// Check for null bytes
  static bool hasNullBytes(String value) {
    final nullRegex = RegExp(ValidationConstants.nullBytePattern);
    return nullRegex.hasMatch(value);
  }

  /// Escape HTML special characters
  static String escapeHtml(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }

  /// Sanitize input: trim, remove potential injections, escape
  static String sanitize(String? value) {
    if (value == null) return '';
    
    String sanitized = normalizeWhitespace(value);
    sanitized = normalizeUnicode(sanitized);
    
    // Check for injection attempts
    if (isXSSAttempt(sanitized) || hasNullBytes(sanitized)) {
      return '';
    }
    
    return sanitized;
  }

  // ════════════════════════════════════════════════════════════════
  // EMAIL VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate email format (RFC 5321/5322 compliant)
  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;

    final emailRegex = RegExp(ValidationConstants.emailPattern);
    final trimmedEmail = email.trim().toLowerCase();

    // Check pattern match
    if (!emailRegex.hasMatch(trimmedEmail)) return false;

    // Check length constraints
    if (trimmedEmail.length < ValidationConstants.emailMinLength ||
        trimmedEmail.length > ValidationConstants.emailMaxLength) {
      return false;
    }

    // Check for multiple @ symbols
    if (trimmedEmail.split('@').length != 2) return false;

    // Check for consecutive dots
    if (trimmedEmail.contains('..')) return false;

    // Check for dot at start or end of local part
    final parts = trimmedEmail.split('@');
    if (parts[0].startsWith('.') || parts[0].endsWith('.')) return false;

    return true;
  }

  /// Get email error message
  static String getEmailErrorMessage(String? email) {
    if (email == null || email.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!isValidEmail(email)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // PASSWORD VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Check if password has uppercase letters
  static bool hasUppercase(String password) {
    return RegExp(ValidationConstants.passwordUppercasePattern).hasMatch(password);
  }

  /// Check if password has lowercase letters
  static bool hasLowercase(String password) {
    return RegExp(ValidationConstants.passwordLowercasePattern).hasMatch(password);
  }

  /// Check if password has digits
  static bool hasDigit(String password) {
    return RegExp(ValidationConstants.passwordDigitPattern).hasMatch(password);
  }

  /// Check if password has special characters
  static bool hasSpecialChar(String password) {
    return RegExp(ValidationConstants.passwordSpecialCharPattern).hasMatch(password);
  }

  /// Check for consecutive repeated characters (e.g., "aaa", "111")
  static bool hasConsecutiveRepeats(String password) {
    return RegExp(r'(.)\1{2,}').hasMatch(password);
  }

  /// Check if password matches common patterns (very simple check)
  static bool matchesCommonPattern(String password) {
    final commonPatterns = [
      '123456',
      '654321',
      '000000',
      '111111',
      'qwerty',
      'asdfgh',
      'zxcvbn',
      '12345678',
      '87654321',
    ];

    final lowerPassword = password.toLowerCase();
    return commonPatterns.any((pattern) => lowerPassword.contains(pattern));
  }

  /// Validate password strength
  static bool isValidPassword(String? password) {
    if (password == null) return false;

    // Check minimum length
    if (password.length < ValidationConstants.passwordMinLength) return false;

    // Check maximum length
    if (password.length > ValidationConstants.passwordMaxLength) return false;

    // Check complexity requirements
    if (!hasUppercase(password)) return false;
    if (!hasLowercase(password)) return false;
    if (!hasDigit(password)) return false;
    if (!hasSpecialChar(password)) return false;

    // Check for consecutive repeats
    if (hasConsecutiveRepeats(password)) return false;

    // Check for common patterns
    if (matchesCommonPattern(password)) return false;

    return true;
  }

  /// Get detailed password validation result
  static Map<String, bool> getPasswordValidationDetails(String? password) {
    if (password == null) password = '';

    return {
      'lengthValid': password.length >= ValidationConstants.passwordMinLength &&
          password.length <= ValidationConstants.passwordMaxLength,
      'hasUppercase': hasUppercase(password),
      'hasLowercase': hasLowercase(password),
      'hasDigit': hasDigit(password),
      'hasSpecialChar': hasSpecialChar(password),
      'noConsecutiveRepeats': !hasConsecutiveRepeats(password),
      'noCommonPatterns': !matchesCommonPattern(password),
    };
  }

  /// Get password error message
  static String getPasswordErrorMessage(String? password) {
    if (password == null || password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (password.length < ValidationConstants.passwordMinLength) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }

    if (password.length > ValidationConstants.passwordMaxLength) {
      return 'كلمة المرور طويلة جداً (128 حرف كحد أقصى)';
    }

    if (!hasUppercase(password)) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير';
    }

    if (!hasLowercase(password)) {
      return 'كلمة المرور يجب أن تحتوي على حرف صغير';
    }

    if (!hasDigit(password)) {
      return 'كلمة المرور يجب أن تحتوي على رقم';
    }

    if (!hasSpecialChar(password)) {
      return 'كلمة المرور يجب أن تحتوي على رمز خاص (@\$!%*?&)';
    }

    if (hasConsecutiveRepeats(password)) {
      return 'كلمة المرور لا يمكنها أن تحتوي على أحرف متتالية متطابقة';
    }

    if (matchesCommonPattern(password)) {
      return 'كلمة المرور ضعيفة جداً (نمط شائع جداً)';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // NAME VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate name format
  static bool isValidName(String? name) {
    if (name == null || name.isEmpty) return false;

    final trimmed = name.trim();

    // Check length
    if (trimmed.length < ValidationConstants.nameMinLength ||
        trimmed.length > ValidationConstants.nameMaxLength) {
      return false;
    }

    // Check for numbers
    if (RegExp(r'\d').hasMatch(trimmed)) return false;

    // Check for consecutive spaces
    if (trimmed.contains('  ')) return false;

    // Basic character validation (letters, spaces, hyphens, apostrophes)
    final nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s\-']+$");
    if (!nameRegex.hasMatch(trimmed)) return false;

    return true;
  }

  /// Get name error message
  static String getNameErrorMessage(String? name) {
    if (name == null || name.isEmpty) {
      return 'الاسم مطلوب';
    }

    final trimmed = name.trim();

    if (trimmed.length < ValidationConstants.nameMinLength) {
      return 'الاسم يجب أن يكون 2 أحرف على الأقل';
    }

    if (trimmed.length > ValidationConstants.nameMaxLength) {
      return 'الاسم طويل جداً (100 أحرف كحد أقصى)';
    }

    if (RegExp(r'\d').hasMatch(trimmed)) {
      return 'الاسم لا يمكنه أن يحتوي على أرقام';
    }

    if (trimmed.contains('  ')) {
      return 'الاسم لا يمكنه أن يحتوي على مسافات متتالية';
    }

    final nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s\-']+$");
    if (!nameRegex.hasMatch(trimmed)) {
      return 'الاسم يجب أن يحتوي على أحرف فقط';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // PHONE VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate Qatar phone number
  static bool isValidQatarPhone(String? phone) {
    if (phone == null || phone.isEmpty) return false;

    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length != ValidationConstants.qatarPhoneLength) return false;

    final firstDigit = int.tryParse(cleaned[0]) ?? 0;
    return firstDigit >= 3 && firstDigit <= 9;
  }

  /// Get Qatar phone error message
  static String getQatarPhoneErrorMessage(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.isEmpty) {
      return 'رقم الهاتف غير صحيح';
    }

    if (cleaned.length != ValidationConstants.qatarPhoneLength) {
      return 'رقم الهاتف يجب أن يكون 8 أرقام';
    }

    final firstDigit = int.tryParse(cleaned[0]) ?? 0;
    if (firstDigit < 3 || firstDigit > 9) {
      return 'رقم الهاتف يجب أن يبدأ برقم من 3 إلى 9';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // ADDRESS VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate address format
  static bool isValidAddress(String? address) {
    if (address == null || address.isEmpty) return true; // Optional field

    final trimmed = address.trim();

    // Check length
    if (trimmed.length < ValidationConstants.addressMinLength ||
        trimmed.length > ValidationConstants.addressMaxLength) {
      return false;
    }

    // Check for XSS attempts
    if (isXSSAttempt(trimmed)) return false;

    // Check for consecutive spaces
    if (trimmed.contains('  ')) return false;

    return true;
  }

  /// Get address error message
  static String getAddressErrorMessage(String? address) {
    if (address == null || address.isEmpty) {
      return ''; // Optional field
    }

    final trimmed = address.trim();

    if (trimmed.length < ValidationConstants.addressMinLength) {
      return 'العنوان يجب أن يكون ${ValidationConstants.addressMinLength} أحرف على الأقل';
    }

    if (trimmed.length > ValidationConstants.addressMaxLength) {
      return 'العنوان طويل جداً';
    }

    if (isXSSAttempt(trimmed)) {
      return 'العنوان يحتوي على أحرف غير صحيحة';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // GENDER VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate gender value
  static bool isValidGender(String? gender) {
    if (gender == null || gender.isEmpty) return false;

    final normalized = gender.toLowerCase();
    return ValidationConstants.validGenders.contains(normalized);
  }

  /// Get gender error message
  static String getGenderErrorMessage(String? gender) {
    if (gender == null || gender.isEmpty) {
      return 'النوع مطلوب';
    }

    if (!isValidGender(gender)) {
      return 'النوع غير صحيح (ذكر / أنثى / أخرى)';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // OTP VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate OTP format
  static bool isValidOtp(String? otp) {
    if (otp == null || otp.isEmpty) return false;

    final cleaned = otp.replaceAll(RegExp(r'[^0-9]'), '');
    final otpRegex = RegExp(ValidationConstants.otpPattern);

    return otpRegex.hasMatch(cleaned);
  }

  /// Get OTP error message
  static String getOtpErrorMessage(String? otp) {
    if (otp == null || otp.isEmpty) {
      return 'الرمز مطلوب';
    }

    if (!isValidOtp(otp)) {
      return 'الرمز يجب أن يكون 6 أرقام';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // BIO VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate bio
  static bool isValidBio(String? bio) {
    if (bio == null || bio.isEmpty) return true; // Optional

    final trimmed = bio.trim();

    // Check length
    if (trimmed.length > ValidationConstants.bioMaxLength) return false;

    // Check for XSS attempts
    if (isXSSAttempt(trimmed)) return false;

    return true;
  }

  /// Get bio error message
  static String getBioErrorMessage(String? bio) {
    if (bio == null || bio.isEmpty) {
      return ''; // Optional
    }

    final trimmed = bio.trim();

    if (trimmed.length > ValidationConstants.bioMaxLength) {
      return 'النبذة طويلة جداً (500 أحرف كحد أقصى)';
    }

    if (isXSSAttempt(trimmed)) {
      return 'النبذة تحتوي على أحرف غير صحيحة';
    }

    return '';
  }

  // ════════════════════════════════════════════════════════════════
  // CROSS-FIELD VALIDATION
  // ════════════════════════════════════════════════════════════════

  /// Validate that two passwords match
  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  /// Get password match error message
  static String getPasswordMatchErrorMessage(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return 'كلا حقلي كلمة المرور مطلوبان';
    }

    if (!passwordsMatch(password, confirmPassword)) {
      return 'كلمتا المرور غير متطابقتين';
    }

    return '';
  }
}
