import '../../domain/entities/home_data_entity.dart';
import 'banner_model.dart';
import 'category_model.dart';
import 'service_model.dart';

class HomeDataModel {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ServiceModel> services;

  const HomeDataModel({
    required this.banners,
    required this.categories,
    required this.services,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      banners: (json['banners'] as List<dynamic>? ?? [])
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      services: (json['featuredServices'] as List<dynamic>? ?? [])
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  HomeDataEntity toEntity() {
    return HomeDataEntity(
      banners: banners.map((e) => e.toEntity()).toList(),
      categories: categories.map((e) => e.toEntity()).toList(),
      services: services.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banners': banners.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
      'featuredServices': services.map((e) => e.toJson()).toList(),
    };
  }
}
