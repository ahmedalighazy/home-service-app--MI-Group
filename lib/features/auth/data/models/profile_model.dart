/// Complete Profile Request Model - Data Layer
class CompleteProfileRequestModel {
  final String phoneNumber;
  final String name;
  final String email;
  final String gender;
  final String? address;
  final String? bio;

  CompleteProfileRequestModel({
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.gender,
    this.address,
    this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'gender': gender,
      'address': address,
      'bio': bio,
    };
  }
}

/// Password Reset Request Model - Data Layer
class PasswordResetRequestModel {
  final String email;
  final String newPassword;
  final String resetCode;

  PasswordResetRequestModel({
    required this.email,
    required this.newPassword,
    required this.resetCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
      'resetCode': resetCode,
    };
  }
}
