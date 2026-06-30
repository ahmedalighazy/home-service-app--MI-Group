// ========== Request Models ==========

class LoginRequestModel {
  final String? identifier;
  final String? password;
  LoginRequestModel({this.identifier, this.password});
  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'password': password,
  };
}

class RegisterRequest {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? role; // 'ADMIN' or 'USER'
  RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.role,
  });
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
    'role': role,
  };
}

class RegisterEmailRequest {
  final String? email;
  RegisterEmailRequest({this.email});
  Map<String, dynamic> toJson() => {'email': email};
}

class RegisterVerifyOtpRequest {
  final String? email;
  final String? otp;
  RegisterVerifyOtpRequest({this.email, this.otp});
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class CompleteProfileRequest {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  CompleteProfileRequest({this.email, this.name, this.phone, this.password});
  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'phone': phone,
    'password': password,
  };
}

class ResendOtpRequest {
  final String? email;
  ResendOtpRequest({this.email});
  Map<String, dynamic> toJson() => {'email': email};
}

class ActivateAccountRequest {
  final String? email;
  final String? otp;
  ActivateAccountRequest({this.email, this.otp});
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class ForgotPasswordRequest {
  final String? email;
  ForgotPasswordRequest({this.email});
  Map<String, dynamic> toJson() => {'email': email};
}

class VerifyResetOtpRequest {
  final String? email;
  final String? otp;
  VerifyResetOtpRequest({this.email, this.otp});
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class ResetPasswordRequest {
  final String? email;
  final String? otp;
  final String? newPassword;
  ResetPasswordRequest({this.email, this.otp, this.newPassword});
  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
    'newPassword': newPassword,
  };
}

class VerifyOtpRequest {
  final String? email;
  final String? otp;
  VerifyOtpRequest({this.email, this.otp});
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class PasswordResetRequest {
  final String? email;
  final String? otp;
  final String? password;
  PasswordResetRequest({this.email, this.otp, this.password});
  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
    'password': password,
  };
}

class PasswordRequestResetRequest {
  final String? email;
  PasswordRequestResetRequest({this.email});
  Map<String, dynamic> toJson() => {'email': email};
}
