import '../../domain/entities/service_addon_entity.dart';

class ServiceAddonModel {
  final String id;
  final String name;
  final String subtitle;
  final String image;
  final double price;

  const ServiceAddonModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.price,
  });

  factory ServiceAddonModel.fromJson(Map<String, dynamic> json) {
    return ServiceAddonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      subtitle: json['subtitle'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  ServiceAddonEntity toEntity() {
    return ServiceAddonEntity(
      id: id,
      name: name,
      subtitle: subtitle,
      image: image,
      price: price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'image': image,
      'price': price,
    };
  }
}
