/// User Profile Entity - Domain Layer
/// 
/// Represents user profile information
class UserProfile {
  final String id;
  final String email;
  final String phone;
  final String? name;
  final String? profileImage;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? address;
  final String? bio;

  const UserProfile({
    required this.id,
    required this.email,
    required this.phone,
    this.name,
    this.profileImage,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.bio,
  });

  UserProfile copyWith({
    String? id,
    String? email,
    String? phone,
    String? name,
    String? profileImage,
    String? gender,
    DateTime? dateOfBirth,
    String? address,
    String? bio,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      bio: bio ?? this.bio,
    );
  }
}
