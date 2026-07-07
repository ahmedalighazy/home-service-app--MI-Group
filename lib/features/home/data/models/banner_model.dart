import '../../domain/entities/banner_entity.dart';

class BannerModel {
  final String id;
  final String imageUrl;
  final String redirectUrl;
  final String listingId;
  final String listingTitle;
  final int displayOrder;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BannerModel({
    required this.id,
    required this.imageUrl,
    required this.redirectUrl,
    required this.listingId,
    required this.listingTitle,
    required this.displayOrder,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      redirectUrl: json['redirectUrl'] ?? '',
      listingId: json['listingId'] ?? '',
      listingTitle: json['listingTitle'] ?? '',
      displayOrder: json['displayOrder'] ?? 0,
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  BannerEntity toEntity() {
    return BannerEntity(
      id: id,
      imageUrl: imageUrl,
      redirectUrl: redirectUrl,
      listingId: listingId,
      listingTitle: listingTitle,
      displayOrder: displayOrder,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'redirectUrl': redirectUrl,
      'listingId': listingId,
      'listingTitle': listingTitle,
      'displayOrder': displayOrder,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
