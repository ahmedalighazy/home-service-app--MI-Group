class ValidationConstants {

  ValidationConstants._();

  static const String emailPattern =
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';

  static const int emailMinLength = 5;
  static const int emailMaxLength = 254;

  static const String passwordUppercasePattern = r'[A-Z]';

  static const String passwordLowercasePattern = r'[a-z]';

  static const String passwordDigitPattern = r'\d';

  static const String passwordSpecialCharPattern = r'[@$!%*?&_\-\.\#\(\)\[\]\{\}]';

  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;

  static const String qatarPhonePattern = r'^[3-9]\d{7}$';

  static const String internationalPhonePattern = r'^\+?[1-9]\d{1,14}$';

  static const int qatarPhoneLength = 8;
  static const int phoneMinLength = 7;
  static const int phoneMaxLength = 15;

  static const String namePattern =
      r"^[\p{L}\s\-']+$";

  static const int nameMinLength = 2;
  static const int nameMaxLength = 100;

  static const String addressPattern =
      r'^[a-zA-Z0-9\u0600-\u06FF\s\-,\.#]+$';

  static const int addressMinLength = 5;
  static const int addressMaxLength = 255;

  static const int bioMinLength = 0;
  static const int bioMaxLength = 500;

  static const String otpPattern = r'^\d{6}$';

  static const int otpLength = 6;
  static const int otpExpirationSeconds = 600;
  static const int otpMaxAttempts = 5;
  static const int otpRateLimitSeconds = 60;

  static const List<String> validGenders = ['male', 'female', 'other'];

  static const String xssPattern =
      r'<script|<iframe|javascript:|on\w+\s*=|<html|<body';

  static const String sqlInjectionPattern = r'''[;'"\\]''';

  static const String nullBytePattern = r'\x00';

  static String getPasswordRequirements() {
    return '''Password must contain:
• Minimum 8 characters
• At least 1 uppercase letter (A-Z)
• At least 1 lowercase letter (a-z)
• At least 1 digit (0-9)
• At least 1 special character (@\$!%*?&)''';
  }

  static String getEmailRequirements() {
    return 'Please enter a valid email address (e.g., user@example.com)';
  }

  static String getPhoneRequirements() {
    return 'Please enter a valid Qatar phone number (8 digits starting with 3-9)';
  }

  static String getNameRequirements() {
    return '''Name must:
• Be 2-100 characters long
• Contain only letters, spaces, hyphens, or apostrophes
• Not contain numbers or special characters''';
  }
}
