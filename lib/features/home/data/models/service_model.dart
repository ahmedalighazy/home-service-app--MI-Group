import '../../domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.title,
    required super.imagePath,
    super.badge,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      title: json['title'] ?? '',
      imagePath: json['image_path'] ?? '',
      badge: json['badge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'image_path': imagePath, 'badge': badge};
  }
}
