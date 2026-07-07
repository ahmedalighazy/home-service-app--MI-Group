import 'package:home_service_app/features/home/data/models/service_addon_model.dart';

import '../../domain/entities/service_entity.dart';

class ServiceModel {
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
  final List<ServiceAddonModel> addons;

  const ServiceModel({
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

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      includedServices: (json['includedServices'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      addons: (json['addons'] as List<dynamic>? ?? [])
          .map((e) => ServiceAddonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      name: name,
      tag: tag,
      image: image,
      description: description,
      price: price,
      averageRating: averageRating,
      reviewCount: reviewCount,
      includedServices: includedServices,
      images: images,
      addons: addons.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tag': tag,
      'image': image,
      'description': description,
      'price': price,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'includedServices': includedServices,
      'images': images,
      'addons': addons.map((e) => e.toJson()).toList(),
    };
  }
}
