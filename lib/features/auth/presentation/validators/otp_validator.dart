/// Validates OTP (One-Time Password) input
/// 
/// This validator ensures OTP meets the required 6-digit format.
/// Usage:
/// ```dart
/// if (!OtpValidator.isOtpValid(code)) {
///   final error = OtpValidator.validateOtp(code);
///   // Show error to user
/// }
/// ```
class OtpValidator {
  /// Validate OTP code
  /// 
  /// Returns null if OTP is valid, error message otherwise.
  /// OTP must be exactly 6 digits.
  static String? validateOtp(String otp) {
    if (otp.isEmpty) {
      return 'OTP code is required';
    }
    if (otp.length != 6) {
      return 'OTP code must be exactly 6 digits';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      return 'OTP code must contain only numbers';
    }
    return null;
  }

  /// Check if OTP code is valid
  static bool isOtpValid(String otp) {
    return validateOtp(otp) == null;
  }

  /// Get error message for invalid OTP
  static String getOtpErrorMessage(String otp) {
    return validateOtp(otp) ?? '';
  }

  /// Check if OTP is complete (6 digits)
  static bool isOtpComplete(String otp) {
    return otp.length == 6;
  }
}
