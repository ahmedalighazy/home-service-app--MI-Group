import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String role;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? serviceProviderId;
  final String? serviceProviderName;
  final String? serviceProviderAvatar;
  final String? serviceProviderStatus;
  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.role,
    required this.isVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.serviceProviderId,
    this.serviceProviderName,
    this.serviceProviderAvatar,
    this.serviceProviderStatus,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      role: json['role'],
      isVerified: json['isVerified'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      serviceProviderId: json['serviceProviderId'],
      serviceProviderName: json['serviceProviderName'],
      serviceProviderAvatar: json['serviceProviderAvatar'],
      serviceProviderStatus: json['serviceProviderStatus'],
    );
  }

  @override
  List<Object?> get props => [];
}
