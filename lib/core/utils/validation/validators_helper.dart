import 'package:home_service_app/core/utils/validation/validation_constants.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class ValidatorsHelper {
  ValidatorsHelper._();

  static String trim(String? value) {
    return value?.trim() ?? '';
  }

  static String normalizeWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String normalizeUnicode(String value) {
    return value.trim();
  }

  static bool isXSSAttempt(String value) {
    final xssRegex = RegExp(
      ValidationConstants.xssPattern,
      caseSensitive: false,
    );
    return xssRegex.hasMatch(value);
  }

  static bool isSQLInjectionAttempt(String value) {
    final sqlRegex = RegExp(ValidationConstants.sqlInjectionPattern);
    return sqlRegex.hasMatch(value);
  }

  static bool hasNullBytes(String value) {
    final nullRegex = RegExp(ValidationConstants.nullBytePattern);
    return nullRegex.hasMatch(value);
  }

  static String escapeHtml(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }

  static String sanitize(String? value) {
    if (value == null) return '';

    String sanitized = normalizeWhitespace(value);
    sanitized = normalizeUnicode(sanitized);

    if (isXSSAttempt(sanitized) || hasNullBytes(sanitized)) {
      return '';
    }

    return sanitized;
  }

  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;

    final emailRegex = RegExp(ValidationConstants.emailPattern);
    final trimmedEmail = email.trim().toLowerCase();

    if (!emailRegex.hasMatch(trimmedEmail)) return false;

    if (trimmedEmail.length < ValidationConstants.emailMinLength ||
        trimmedEmail.length > ValidationConstants.emailMaxLength) {
      return false;
    }

    if (trimmedEmail.split('@').length != 2) return false;

    if (trimmedEmail.contains('..')) return false;

    final parts = trimmedEmail.split('@');
    if (parts[0].startsWith('.') || parts[0].endsWith('.')) return false;

    return true;
  }

  static String getEmailErrorMessage(String? email) {
    if (email == null || email.isEmpty) {
      return AuthStrings.emailRequired;
    }
    if (!isValidEmail(email)) {
      return AuthStrings.invalidEmail;
    }
    return '';
  }

  static bool hasUppercase(String password) {
    return RegExp(
      ValidationConstants.passwordUppercasePattern,
    ).hasMatch(password);
  }

  static bool hasLowercase(String password) {
    return RegExp(
      ValidationConstants.passwordLowercasePattern,
    ).hasMatch(password);
  }

  static bool hasDigit(String password) {
    return RegExp(ValidationConstants.passwordDigitPattern).hasMatch(password);
  }

  static bool hasSpecialChar(String password) {
    return RegExp(
      ValidationConstants.passwordSpecialCharPattern,
    ).hasMatch(password);
  }

  static bool hasConsecutiveRepeats(String password) {
    return RegExp(r'(.)\1{2,}').hasMatch(password);
  }

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

  static bool isValidPassword(String? password) {
    if (password == null) return false;

    if (password.length < ValidationConstants.passwordMinLength) return false;

    if (password.length > ValidationConstants.passwordMaxLength) return false;

    if (!hasUppercase(password)) return false;
    if (!hasLowercase(password)) return false;
    if (!hasDigit(password)) return false;
    if (!hasSpecialChar(password)) return false;

    if (hasConsecutiveRepeats(password)) return false;

    if (matchesCommonPattern(password)) return false;

    return true;
  }

  static Map<String, bool> getPasswordValidationDetails(String? password) {
    password ??= '';

    return {
      'lengthValid':
          password.length >= ValidationConstants.passwordMinLength &&
          password.length <= ValidationConstants.passwordMaxLength,
      'hasUppercase': hasUppercase(password),
      'hasLowercase': hasLowercase(password),
      'hasDigit': hasDigit(password),
      'hasSpecialChar': hasSpecialChar(password),
      'noConsecutiveRepeats': !hasConsecutiveRepeats(password),
      'noCommonPatterns': !matchesCommonPattern(password),
    };
  }

  static String getPasswordErrorMessage(String? password) {
    if (password == null || password.isEmpty) {
      return AuthStrings.passwordRequired;
    }

    if (password.length < ValidationConstants.passwordMinLength) {
      return AuthStrings.passwordMinLengthError;
    }

    if (password.length > ValidationConstants.passwordMaxLength) {
      return AuthStrings.passwordMaxLengthError;
    }

    if (!hasUppercase(password)) {
      return AuthStrings.passwordUppercaseError;
    }

    if (!hasLowercase(password)) {
      return AuthStrings.passwordLowercaseError;
    }

    if (!hasDigit(password)) {
      return AuthStrings.passwordDigitError;
    }

    if (!hasSpecialChar(password)) {
      return AuthStrings.passwordSpecialCharError;
    }

    if (hasConsecutiveRepeats(password)) {
      return AuthStrings.passwordConsecutiveRepeatsError;
    }

    if (matchesCommonPattern(password)) {
      return AuthStrings.passwordCommonPatternError;
    }

    return '';
  }

  static bool isValidName(String? name) {
    if (name == null || name.isEmpty) return false;

    final trimmed = name.trim();

    if (trimmed.length < ValidationConstants.nameMinLength ||
        trimmed.length > ValidationConstants.nameMaxLength) {
      return false;
    }

    if (RegExp(r'\d').hasMatch(trimmed)) return false;

    if (trimmed.contains('  ')) return false;

    final nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s\-']+$");
    if (!nameRegex.hasMatch(trimmed)) return false;

    return true;
  }

  static String getNameErrorMessage(String? name) {
    if (name == null || name.isEmpty) {
      return AuthStrings.nameRequired;
    }

    final trimmed = name.trim();

    if (trimmed.length < ValidationConstants.nameMinLength) {
      return AuthStrings.nameMinLengthError;
    }

    if (trimmed.length > ValidationConstants.nameMaxLength) {
      return AuthStrings.nameMaxLengthError;
    }

    if (RegExp(r'\d').hasMatch(trimmed)) {
      return AuthStrings.nameContainsNumbersError;
    }

    if (trimmed.contains('  ')) {
      return AuthStrings.nameConsecutiveSpacesError;
    }

    final nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s\-']+$");
    if (!nameRegex.hasMatch(trimmed)) {
      return AuthStrings.nameLettersOnlyError;
    }

    return '';
  }

  static bool isValidQatarPhone(String? phone) {
    if (phone == null || phone.isEmpty) return false;

    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length != ValidationConstants.qatarPhoneLength) return false;

    final firstDigit = int.tryParse(cleaned[0]) ?? 0;
    return firstDigit >= 3 && firstDigit <= 9;
  }

  static String getQatarPhoneErrorMessage(String? phone) {
    if (phone == null || phone.isEmpty) {
      return AuthStrings.phoneRequired;
    }

    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.isEmpty) {
      return AuthStrings.phoneInvalid;
    }

    if (cleaned.length != ValidationConstants.qatarPhoneLength) {
      return AuthStrings.phoneLengthError;
    }

    final firstDigit = int.tryParse(cleaned[0]) ?? 0;
    if (firstDigit < 3 || firstDigit > 9) {
      return AuthStrings.phoneStartDigitError;
    }

    return '';
  }

  static bool isValidAddress(String? address) {
    if (address == null || address.isEmpty) return true;

    final trimmed = address.trim();

    if (trimmed.length < ValidationConstants.addressMinLength ||
        trimmed.length > ValidationConstants.addressMaxLength) {
      return false;
    }

    if (isXSSAttempt(trimmed)) return false;

    if (trimmed.contains('  ')) return false;

    return true;
  }

  static String getAddressErrorMessage(String? address) {
    if (address == null || address.isEmpty) {
      return '';
    }

    final trimmed = address.trim();

    if (trimmed.length < ValidationConstants.addressMinLength) {
      return AuthStrings.addressMinLengthError;
    }

    if (trimmed.length > ValidationConstants.addressMaxLength) {
      return AuthStrings.addressMaxLengthError;
    }

    if (isXSSAttempt(trimmed)) {
      return AuthStrings.addressInvalidCharactersError;
    }

    return '';
  }

  static bool isValidGender(String? gender) {
    if (gender == null || gender.isEmpty) return false;

    final normalized = gender.toLowerCase();
    return ValidationConstants.validGenders.contains(normalized);
  }

  static String getGenderErrorMessage(String? gender) {
    if (gender == null || gender.isEmpty) {
      return AuthStrings.genderRequired;
    }

    if (!isValidGender(gender)) {
      return AuthStrings.genderInvalid;
    }

    return '';
  }

  static bool isValidOtp(String? otp) {
    if (otp == null || otp.isEmpty) return false;

    final cleaned = otp.replaceAll(RegExp(r'[^0-9]'), '');
    final otpRegex = RegExp(ValidationConstants.otpPattern);

    return otpRegex.hasMatch(cleaned);
  }

  static String getOtpErrorMessage(String? otp) {
    if (otp == null || otp.isEmpty) {
      return AuthStrings.otpRequired;
    }

    if (!isValidOtp(otp)) {
      return AuthStrings.otpInvalid;
    }

    return '';
  }

  static bool isValidBio(String? bio) {
    if (bio == null || bio.isEmpty) return true;

    final trimmed = bio.trim();

    if (trimmed.length > ValidationConstants.bioMaxLength) return false;

    if (isXSSAttempt(trimmed)) return false;

    return true;
  }

  static String getBioErrorMessage(String? bio) {
    if (bio == null || bio.isEmpty) {
      return '';
    }

    final trimmed = bio.trim();

    if (trimmed.length > ValidationConstants.bioMaxLength) {
      return AuthStrings.bioMaxLengthError;
    }

    if (isXSSAttempt(trimmed)) {
      return AuthStrings.bioInvalidCharactersError;
    }

    return '';
  }

  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static String getPasswordMatchErrorMessage(
    String password,
    String confirmPassword,
  ) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return AuthStrings.passwordsRequired;
    }

    if (!passwordsMatch(password, confirmPassword)) {
      return AuthStrings.passwordMismatch;
    }

    return '';
  }
}
