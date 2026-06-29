import 'package:home_service_app/core/utils/validation/validators_helper.dart';

/// Validates Sign Up form data (Email & Phone verification step)
/// 
/// This validator ensures phone number meets Qatar requirements and email is formatted correctly.
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

  /// Validate email address
  /// 
  /// Returns null if email is valid, error message otherwise.
  static String? validateEmail(String email) {
    final err = ValidatorsHelper.getEmailErrorMessage(email);
    return err.isEmpty ? null : err;
  }

  /// Check if email is valid
  static bool isEmailValid(String email) {
    return validateEmail(email) == null;
  }

  /// Get formatted email error message
  static String getEmailErrorMessage(String email) {
    return validateEmail(email) ?? '';
  }
}
