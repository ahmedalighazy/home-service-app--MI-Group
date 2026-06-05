import '../../domain/entities/home_data_entity.dart';
import 'banner_model.dart';
import 'category_model.dart';
import 'service_model.dart';

class HomeDataModel extends HomeDataEntity {
  const HomeDataModel({
    required super.banner,
    required super.categories,
    required super.services,
  });

  Map<String, dynamic> toJson() {
    return {
      'banner': (banner as BannerModel).toJson(),
      'categories': categories
          .map((e) => (e as CategoryModel).toJson())
          .toList(),
      'services': services.map((e) => (e as ServiceModel).toJson()).toList(),
    };
  }

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      banner: BannerModel.fromJson(
        json['banner'] as Map<String, dynamic>? ?? {},
      ),
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      services: (json['services'] as List<dynamic>? ?? [])
          .map((e) => ServiceModel.fromJson(e))
          .toList(),
    );
  }
}
