class ApiErrorModel {
  final String? timestamp;
  final int? status;
  final String? error;
  final String? message;

  const ApiErrorModel({this.timestamp, this.status, this.error, this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      timestamp: json['timestamp'] as String?,
      status: json['status'] as int?,
      error: json['error'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'status': status,
      'error': error,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ApiErrorModel('
        'timestamp: $timestamp, '
        'status: $status, '
        'error: $error, '
        'message: $message'
        ')';
  }

  // دالة لتحويل الرسائل إلى رسائل معبرة بأحرف صغيرة
  String getLocalizedErrorMessage() {
    final original = message?.toLowerCase() ?? '';

    if (original.contains('email sending failed') ||
        original.contains('failed to send email')) {
      return "couldn't send the email. please check your address and try again.";
    }
    if (original.contains('invalid otp') ||
        original.contains('otp invalid')) {
      return "the verification code is invalid or expired. please request a new one.";
    }
    if (original.contains('invalid credentials')) {
      return "incorrect username or password. please double-check your entries.";
    }
    if (original.contains('user not found')) {
      return "no account found with this email. would you like to sign up?";
    }
    if (original.contains('invalid email') ||
        original.contains('invalid password')) {
      return "the email or password you entered is incorrect. please try again.";
    }

    return "something went wrong. please try again later. (error: $message)";
  }
}