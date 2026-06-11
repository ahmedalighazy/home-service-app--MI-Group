/// OTP Request Model - Data Layer
/// 
/// DTO for OTP verification API request
class OtpRequestModel {
  final String phoneNumber;
  final String otp;

  OtpRequestModel({
    required this.phoneNumber,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'otp': otp,
    };
  }
}

/// OTP Response Model - Data Layer
class OtpResponseModel {
  final String otpId;
  final int expiresIn;

  OtpResponseModel({
    required this.otpId,
    required this.expiresIn,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      otpId: json['otpId'] as String? ?? '',
      expiresIn: json['expiresIn'] as int? ?? 300,
    );
  }
}
