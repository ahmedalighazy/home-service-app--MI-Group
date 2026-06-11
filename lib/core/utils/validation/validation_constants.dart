/// Validation Constants and Regular Expressions
/// 
/// Centralized validation rules for consistent validation across the app
class ValidationConstants {
  // Private constructor
  ValidationConstants._();

  // ════════════════════════════════════════════════════════════════
  // EMAIL VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  /// RFC 5321/5322 compliant email regex
  /// Supports: standard emails, plus addressing, subdomains, international domains
  static const String emailPattern =
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';

  static const int emailMinLength = 5; // a@b.co
  static const int emailMaxLength = 254; // RFC 5321

  // ════════════════════════════════════════════════════════════════
  // PASSWORD VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  /// Password must contain at least one uppercase letter
  static const String passwordUppercasePattern = r'[A-Z]';
  
  /// Password must contain at least one lowercase letter
  static const String passwordLowercasePattern = r'[a-z]';
  
  /// Password must contain at least one digit
  static const String passwordDigitPattern = r'\d';
  
  /// Password must contain at least one special character
  static const String passwordSpecialCharPattern = r'[@$!%*?&_\-\.\#\(\)\[\]\{\}]';

  static const int passwordMinLength = 8; // NIST guidelines
  static const int passwordMaxLength = 128; // Prevent DoS attacks
  
  // ════════════════════════════════════════════════════════════════
  // PHONE VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  /// Qatar phone format: 8 digits starting with 3-9
  /// Matches: 30123456, 50987654, 77654321
  static const String qatarPhonePattern = r'^[3-9]\d{7}$';
  
  /// E.164 international format: +[country][number]
  /// Example: +97430123456, +1-555-123-4567
  static const String internationalPhonePattern = r'^\+?[1-9]\d{1,14}$';

  static const int qatarPhoneLength = 8;
  static const int phoneMinLength = 7;
  static const int phoneMaxLength = 15;

  // ════════════════════════════════════════════════════════════════
  // NAME VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  /// Name can contain letters, spaces, hyphens, and apostrophes
  /// Supports: English, Arabic, and other languages
  /// Does NOT support: numbers or most special characters
  static const String namePattern =
      r"^[\p{L}\s\-']+$"; // Note: \p{L} for unicode letters

  static const int nameMinLength = 2;
  static const int nameMaxLength = 100;

  // ════════════════════════════════════════════════════════════════
  // ADDRESS VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  /// Address field validation pattern
  /// Blocks: HTML tags, script tags, excessive special characters
  static const String addressPattern =
      r'^[a-zA-Z0-9\u0600-\u06FF\s\-,\.#]+$';

  static const int addressMinLength = 5;
  static const int addressMaxLength = 255;

  // ════════════════════════════════════════════════════════════════
  // BIO VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  static const int bioMinLength = 0; // Optional
  static const int bioMaxLength = 500;

  // ════════════════════════════════════════════════════════════════
  // OTP VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  /// OTP must be exactly 6 digits
  static const String otpPattern = r'^\d{6}$';
  
  static const int otpLength = 6;
  static const int otpExpirationSeconds = 600; // 10 minutes
  static const int otpMaxAttempts = 5;
  static const int otpRateLimitSeconds = 60; // 1 request per minute

  // ════════════════════════════════════════════════════════════════
  // GENDER VALIDATION
  // ════════════════════════════════════════════════════════════════
  
  static const List<String> validGenders = ['male', 'female', 'other'];

  // ════════════════════════════════════════════════════════════════
  // XSS PREVENTION PATTERNS
  // ════════════════════════════════════════════════════════════════
  
  /// Detect common HTML/script injection attempts
  static const String xssPattern =
      r'<script|<iframe|javascript:|on\w+\s*=|<html|<body';

  /// Characters that need escaping for database safety
  static const String sqlInjectionPattern = r'''[;'"\\]''';

  /// Null byte detection
  static const String nullBytePattern = r'\x00';

  // ════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ════════════════════════════════════════════════════════════════
  
  /// Get password complexity requirements as a string
  static String getPasswordRequirements() {
    return '''Password must contain:
• Minimum 8 characters
• At least 1 uppercase letter (A-Z)
• At least 1 lowercase letter (a-z)
• At least 1 digit (0-9)
• At least 1 special character (@\$!%*?&)''';
  }

  /// Get email validation requirements
  static String getEmailRequirements() {
    return 'Please enter a valid email address (e.g., user@example.com)';
  }

  /// Get phone validation requirements
  static String getPhoneRequirements() {
    return 'Please enter a valid Qatar phone number (8 digits starting with 3-9)';
  }

  /// Get name validation requirements
  static String getNameRequirements() {
    return '''Name must:
• Be 2-100 characters long
• Contain only letters, spaces, hyphens, or apostrophes
• Not contain numbers or special characters''';
  }
}
