class UserProfile {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String? profileImageUrl;
  final String? address;
  final String? bio;
  final DateTime? dateOfBirth;
  final String? profileCompletionStatus;

  UserProfile({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.profileImageUrl,
    this.address,
    this.bio,
    this.dateOfBirth,
    this.profileCompletionStatus,
  });

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? gender,
    String? profileImageUrl,
    String? address,
    String? bio,
    DateTime? dateOfBirth,
    String? profileCompletionStatus,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileCompletionStatus: profileCompletionStatus ?? this.profileCompletionStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'profileImageUrl': profileImageUrl,
      'address': address,
      'bio': bio,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profileCompletionStatus': profileCompletionStatus,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? 'other',
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
      bio: json['bio'],
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth']) 
          : null,
      profileCompletionStatus: json['profileCompletionStatus'],
    );
  }
}
