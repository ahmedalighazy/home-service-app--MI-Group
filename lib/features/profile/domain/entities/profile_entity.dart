class ProfileEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? bio;
  final List<String>? socialLinks;
  final bool? verified;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final String? lastSeen;
  final String? preferredLanguage;
  final bool? online;

  const ProfileEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.bio,
    this.socialLinks,
    this.verified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.lastSeen,
    this.preferredLanguage,
    this.online,
  });
}
