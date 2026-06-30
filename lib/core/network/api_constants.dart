class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://cleaningapi.twintech-it.com';

  // Auth
  static const String auth = '/auth';

  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String refreshToken = '$auth/refresh-token';
  static const String logout = '$auth/logout';

  // Profile
  static const String profile = '/profile';
  static const String updateProfile = '/profile';
  static const String changePassword = '/profile/change-password';

  // Home
  static const String home = '/home';
}
