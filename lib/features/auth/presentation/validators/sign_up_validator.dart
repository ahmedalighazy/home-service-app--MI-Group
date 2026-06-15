import 'package:home_service_app/core/utils/validation/validators_helper.dart';

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
    final err = ValidatorsHelper.getQatarPhoneErrorMessage(phone);
    return err.isEmpty ? null : err;
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
