import 'package:equatable/equatable.dart';
import 'package:home_service_app/features/home/domain/entities/banner_entity.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/home/domain/entities/service_entity.dart';

class HomeDataEntity extends Equatable {
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ServiceEntity> services;

  const HomeDataEntity({
    required this.banners,
    required this.categories,
    required this.services,
  });

  @override
  List<Object?> get props => [banners, categories, services];
}
