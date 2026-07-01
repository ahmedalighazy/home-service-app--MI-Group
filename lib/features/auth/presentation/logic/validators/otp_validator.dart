class OtpValidator {
  static String? validateOtp(String otp) {
    if (otp.isEmpty) return 'OTP code is required';
    if (otp.length != 6) return 'OTP code must be exactly 6 digits';
    if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      return 'OTP code must contain only numbers';
    }
    return null;
  }

  static bool isOtpValid(String otp) => validateOtp(otp) == null;
  static String getOtpErrorMessage(String otp) => validateOtp(otp) ?? '';
  static bool isOtpComplete(String otp) => otp.length == 6;
}
