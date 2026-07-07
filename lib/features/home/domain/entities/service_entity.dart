import 'package:equatable/equatable.dart';

import 'service_addon_entity.dart';

class ServiceEntity extends Equatable {
  final String id;
  final String name;
  final String tag;
  final String image;
  final String description;
  final double price;
  final double averageRating;
  final int reviewCount;
  final List<String> includedServices;
  final List<String> images;
  final List<ServiceAddonEntity> addons;

  const ServiceEntity({
    required this.id,
    required this.name,
    required this.tag,
    required this.image,
    required this.description,
    required this.price,
    required this.averageRating,
    required this.reviewCount,
    required this.includedServices,
    required this.images,
    required this.addons,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    tag,
    image,
    description,
    price,
    averageRating,
    reviewCount,
    includedServices,
    images,
    addons,
  ];
}
