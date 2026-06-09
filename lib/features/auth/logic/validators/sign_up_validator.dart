import 'package:home_service_app/core/utils/validation/auth_validation.dart';

/// Validates Sign Up form data (Phone verification step)
/// 
/// This validator ensures phone number meets Qatar requirements.
/// Usage:
/// ```dart
/// if (!SignUpValidator.isPhoneValid(phone)) {
///   final error = SignUpValidator.validatePhone(phone);
///   // Show error to user
/// }
/// ```
class SignUpValidator {
  /// Validate phone number
  /// 
  /// Returns null if phone is valid, error message otherwise.
  static String? validatePhone(String phone) {
    if (phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!AuthValidation.isValidQatarPhone(phone)) {
      return AuthValidation.getQatarPhoneErrorMessage(phone);
    }
    return null;
  }

  /// Check if phone number is valid
  static bool isPhoneValid(String phone) {
    return validatePhone(phone) == null;
  }

  /// Get formatted phone error message
  static String getPhoneErrorMessage(String phone) {
    return validatePhone(phone) ?? '';
  }
}
