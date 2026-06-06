import 'package:home_service_app/core/utils/validation/auth_validation.dart';

/// Helper class for Reset Password logic and validation
/// Uses unified validation from AuthValidation to avoid code duplication
@Deprecated('Use AuthValidation class instead')
class ResetPasswordHelper {
  /// Validate OTP code (4 digits)
  static bool isValidOtpCode(String code) => AuthValidation.isValidOtpCode(code);

  /// Validate password (minimum 6 characters)
  static bool isValidPassword(String password) => AuthValidation.isValidPassword(password);

  /// Validate passwords match
  static bool passwordsMatch(String password, String confirmPassword) => AuthValidation.passwordsMatch(password, confirmPassword);

  /// Validate all reset data
  static bool isAllDataValid({
    required String otpCode,
    required String newPassword,
    required String confirmPassword,
  }) {
    return isValidOtpCode(otpCode) &&
        isValidPassword(newPassword) &&
        passwordsMatch(newPassword, confirmPassword);
  }

  /// Get error message for OTP
  static String getOtpErrorMessage(String code) => AuthValidation.getOtpErrorMessage(code);

  /// Get error message for password
  static String getPasswordErrorMessage(String password) => AuthValidation.getPasswordErrorMessage(password);

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

  /// Format countdown time
  static String formatCountdownTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  /// Check if countdown is finished
  static bool isCountdownFinished(int seconds) {
    return seconds <= 0;
  }

  /// Get password strength
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

  /// Sanitize OTP code (remove non-digits)
  static String sanitizeOtpCode(String code) {
    return code.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Get API error message
  static String getApiErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'INVALID_OTP':
        return 'الرمز غير صحيح';
      case 'OTP_EXPIRED':
        return 'انتهت صلاحية الرمز، أرسل رمز جديد';
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

  /// Calculate OTP expiration time (in minutes)
  static int getOtpExpirationTime() {
    return 5; // 5 minutes
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
class ResetPasswordVerifyRequest {
  final String email;
  final String otpCode;
  final String newPassword;

  ResetPasswordVerifyRequest({
    required this.email,
    required this.otpCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otpCode': otpCode,
      'newPassword': newPassword,
    };
  }
}

/// Reset Password Response Model
class ResetPasswordVerifyResponse {
  final bool success;
  final String message;
  final String? token;

  ResetPasswordVerifyResponse({
    required this.success,
    required this.message,
    this.token,
  });

  factory ResetPasswordVerifyResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordVerifyResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }
}

/// Reset Password Exception
class ResetPasswordException implements Exception {
  final String message;
  final String? code;

  ResetPasswordException(this.message, {this.code});

  @override
  String toString() => message;
}
