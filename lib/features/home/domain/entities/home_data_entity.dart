import 'package:equatable/equatable.dart';
import 'package:home_service_app/features/home/domain/entities/banner_entity.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/home/domain/entities/service_entity.dart';

class HomeDataEntity extends Equatable {
  final BannerEntity banner;
  final List<CategoryEntity> categories;
  final List<ServiceEntity> services;

  const HomeDataEntity({
    required this.banner,
    required this.categories,
    required this.services,
  });

  @override
  List<Object?> get props => [banner, categories, services];
}
