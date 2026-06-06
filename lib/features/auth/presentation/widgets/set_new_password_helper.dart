import 'package:home_service_app/core/utils/validation/auth_validation.dart';

/// Helper class for Set New Password logic and validation
/// Uses unified validation from AuthValidation to avoid code duplication
@Deprecated('Use AuthValidation class instead')
class SetNewPasswordHelper {
  /// Validate password (minimum 6 characters)
  static bool isValidPassword(String password) => AuthValidation.isValidPassword(password);

  /// Validate passwords match
  static bool passwordsMatch(String password, String confirmPassword) => AuthValidation.passwordsMatch(password, confirmPassword);

  /// Validate all password data
  static bool isAllPasswordDataValid({
    required String password,
    required String confirmPassword,
  }) {
    return isValidPassword(password) && passwordsMatch(password, confirmPassword);
  }

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

  /// Get password strength indicator color
  static String getPasswordStrengthColor(String strength) {
    switch (strength) {
      case 'weak':
        return '#FF6B6B';
      case 'medium':
        return '#FFD93D';
      case 'strong':
        return '#6BCF7F';
      default:
        return '#CCCCCC';
    }
  }

  /// Get password strength text
  static String getPasswordStrengthText(String strength) {
    switch (strength) {
      case 'weak':
        return 'ضعيفة';
      case 'medium':
        return 'متوسطة';
      case 'strong':
        return 'قوية';
      default:
        return '';
    }
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

  /// Get password requirements
  static List<String> getPasswordRequirements() {
    return [
      'الحد الأدنى 6 أحرف',
      'يمكن أن تحتوي على حروف وأرقام',
      'يمكن أن تحتوي على أحرف كبيرة وصغيرة',
      'يفضل إضافة أحرف خاصة (!@#\$%)',
    ];
  }

  /// Get API error message
  static String getApiErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'INVALID_PASSWORD':
        return 'كلمة المرور ضعيفة جداً';
      case 'PASSWORD_TOO_SIMILAR':
        return 'كلمة المرور الجديدة مشابهة للقديمة';
      case 'PASSWORD_USED_BEFORE':
        return 'هذه كلمة المرور المستخدمة سابقاً';
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
}

/// Set New Password Request Model
class SetNewPasswordRequest {
  final String email;
  final String newPassword;

  SetNewPasswordRequest({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }
}

/// Set New Password Response Model
class SetNewPasswordResponse {
  final bool success;
  final String message;
  final String? token;

  SetNewPasswordResponse({
    required this.success,
    required this.message,
    this.token,
  });

  factory SetNewPasswordResponse.fromJson(Map<String, dynamic> json) {
    return SetNewPasswordResponse(
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

/// Set New Password Exception
class SetNewPasswordException implements Exception {
  final String message;
  final String? code;

  SetNewPasswordException(this.message, {this.code});

  @override
  String toString() => message;
}
