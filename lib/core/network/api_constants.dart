class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://cleaningapi.twintech-it.com';

  // Auth
  static const String auth = '/auth';

  static const String login = '$auth/login';
  static const String loginPhone = '$auth/login/phone';
  static const String loginEmail = '$auth/login/email';
  static const String logout = '$auth/logout';

  static const String register = '$auth/register';
  static const String registerEmail = '$auth/register/email';
  static const String registerVerifyOtp = '$auth/register/verify-otp';
  static const String registerComplete = '$auth/register/complete';

  static const String verifyResetOtp = '$auth/verify-reset-otp';
  static const String resetPassword = '$auth/reset-password';
  static const String resendOtp = '$auth/resend-otp';
  static const String refresh = '$auth/refresh';

  static const String forgotPassword = '$auth/forgot-password';
  static const String passwordVerifyOtp = '$auth/password/verify-otp';
  static const String passwordReset = '$auth/password/reset';
  static const String passwordRequestReset = '$auth/password/request-reset';
  static const String activate = '$auth/activate';
  static const String google = '$auth/google';

  // Profile
  static const String profile = '/profile';
  static const String updateProfile = '/profile';
  static const String changePassword = '/profile/change-password';

  // Home
  static const String home = '/home';
}
