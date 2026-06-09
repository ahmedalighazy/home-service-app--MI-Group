class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? phoneNumber;
  final String? fullName;
  final String? gender;
  final String? profileImageUrl;
  final String? address;
  final String? bio;
  final String? dateOfBirth;
  final bool? profileCompletionStatus;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.phoneNumber,
    this.fullName,
    this.gender,
    this.profileImageUrl,
    this.address,
    this.bio,
    this.dateOfBirth,
    this.profileCompletionStatus,
  });
}
