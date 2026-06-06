import 'package:home_service_app/core/utils/validation/auth_validation.dart';

/// Helper class for Forgot Password logic and validation
/// Uses unified validation from AuthValidation to avoid code duplication
@Deprecated('Use AuthValidation class instead')
class ForgotPasswordHelper {
  /// Validate email format
  static bool isValidEmail(String email) => AuthValidation.isValidEmail(email);

  /// Validate reset code (6 digits only)
  static bool isValidResetCode(String code) => AuthValidation.isValidResetCode(code);

  /// Validate password (minimum 6 characters)
  static bool isValidPassword(String password) => AuthValidation.isValidPassword(password);

  /// Validate passwords match
  static bool passwordsMatch(String password, String confirmPassword) => AuthValidation.passwordsMatch(password, confirmPassword);

  /// Get error message for email
  static String getEmailErrorMessage(String email) => AuthValidation.getEmailErrorMessage(email);

  /// Get error message for reset code
  static String getResetCodeErrorMessage(String code) => AuthValidation.getResetCodeErrorMessage(code);

  /// Get error message for password
  static String getPasswordErrorMessage(String password) {
    if (password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (password.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return '';
  }

  /// Get error message for password confirmation
  static String getConfirmPasswordErrorMessage(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (!passwordsMatch(password, confirmPassword)) {
      return 'كلمات المرور غير متطابقة';
    }
    return '';
  }

  /// Get password strength indicator
  static String getPasswordStrength(String password) {
    if (password.isEmpty) {
      return 'empty';
    }
    if (password.length < 8) {
      return 'weak';
    }
    if (password.length < 12) {
      return 'medium';
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'strong';
    }
    return 'medium';
  }

  /// Verify all reset data
  static Map<String, bool> validateAllResetData({
    required String email,
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) {
    return {
      'emailValid': isValidEmail(email),
      'codeValid': isValidResetCode(resetCode),
      'passwordValid': isValidPassword(newPassword),
      'passwordsMatch': passwordsMatch(newPassword, confirmPassword),
      'allValid': isValidEmail(email) &&
          isValidResetCode(resetCode) &&
          isValidPassword(newPassword) &&
          passwordsMatch(newPassword, confirmPassword),
    };
  }

  /// Sanitize email input
  static String sanitizeEmail(String email) {
    return email.trim().toLowerCase();
  }

  /// Sanitize reset code (remove non-digits)
  static String sanitizeResetCode(String code) {
    return code.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Format reset code for display
  static String formatResetCode(String code) {
    // Format as: 000-000
    if (code.length >= 6) {
      return '${code.substring(0, 3)}-${code.substring(3, 6)}';
    }
    return code;
  }

  /// Get API error message
  static String getApiErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'USER_NOT_FOUND':
        return 'المستخدم غير مسجل';
      case 'INVALID_RESET_CODE':
        return 'الكود غير صحيح أو منتهي الصلاحية';
      case 'CODE_EXPIRED':
        return 'انتهت صلاحية الكود، أرسل كود جديد';
      case 'CODE_NOT_SENT':
        return 'لم يتم إرسال الكود بعد';
      case 'INVALID_PASSWORD':
        return 'كلمة المرور ضعيفة جداً';
      case 'PASSWORD_TOO_SIMILAR':
        return 'كلمة المرور الجديدة مشابهة للقديمة';
      case 'MAX_ATTEMPTS_EXCEEDED':
        return 'محاولات كثيرة جداً، حاول لاحقاً';
      case 'NETWORK_ERROR':
        return 'خطأ في الاتصال بالإنترنت';
      case 'SERVER_ERROR':
        return 'خطأ في الخادم، حاول لاحقاً';
      default:
        return 'حدث خطأ ما، يرجى المحاولة مرة أخرى';
    }
  }

  /// Calculate reset code expiration time (in minutes)
  static int getCodeExpirationTime() {
    return 10; // 10 minutes
  }

  /// Check if reset code is about to expire
  static bool isCodeAboutToExpire(DateTime sentTime, int minutesBeforeExpire) {
    final now = DateTime.now();
    final difference = now.difference(sentTime).inMinutes;
    final expirationTime = getCodeExpirationTime();
    return difference >= (expirationTime - minutesBeforeExpire);
  }

  /// Generate random reset code (for testing)
  static String generateTestResetCode() {
    return List.generate(6, (index) => index.toString()).join();
  }

  /// Get password requirements
  static List<String> getPasswordRequirements() {
    return [
      'الحد الأدنى 6 أحرف',
      'يمكن أن تحتوي على حروف وأرقام',
      'يمكن أن تحتوي على أحرف كبيرة وصغيرة',
      'يفضل إضافة أحرف خاصة (!@#\$%)',
    ];
  }

  /// Check password requirements
  static Map<String, bool> checkPasswordRequirements(String password) {
    return {
      'minLength': password.length >= 6,
      'hasUpperCase': RegExp(r'[A-Z]').hasMatch(password),
      'hasLowerCase': RegExp(r'[a-z]').hasMatch(password),
      'hasNumbers': RegExp(r'[0-9]').hasMatch(password),
      'hasSpecialChars': RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
    };
  }
}

/// Reset Password Request Model
class ResetPasswordRequest {
  final String email;
  final String resetCode;
  final String newPassword;

  ResetPasswordRequest({
    required this.email,
    required this.resetCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'resetCode': resetCode,
      'newPassword': newPassword,
    };
  }
}

/// Reset Password Response Model
class ResetPasswordResponse {
  final bool success;
  final String message;
  final String? resetToken;

  ResetPasswordResponse({
    required this.success,
    required this.message,
    this.resetToken,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      resetToken: json['resetToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'resetToken': resetToken,
    };
  }
}

/// Send Reset Code Request Model
class SendResetCodeRequest {
  final String email;

  SendResetCodeRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}

/// Send Reset Code Response Model
class SendResetCodeResponse {
  final bool success;
  final String message;
  final DateTime? expiresAt;

  SendResetCodeResponse({
    required this.success,
    required this.message,
    this.expiresAt,
  });

  factory SendResetCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendResetCodeResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}

/// Forgot Password Exception
class ForgotPasswordException implements Exception {
  final String message;
  final String? code;

  ForgotPasswordException(this.message, {this.code});

  @override
  String toString() => message;
}
