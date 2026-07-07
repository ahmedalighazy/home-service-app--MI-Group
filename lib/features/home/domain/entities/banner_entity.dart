import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String redirectUrl;
  final String listingId;
  final String listingTitle;
  final int displayOrder;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BannerEntity({
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

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    redirectUrl,
    listingId,
    listingTitle,
    displayOrder,
    isActive,
    createdAt,
    updatedAt,
  ];
}
