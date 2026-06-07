import 'package:home_service_app/features/service_details/data/models/service_category_model.dart';
import 'package:home_service_app/features/service_details/data/models/service_group_model.dart';

class ServicePageModel {
  final String coverImage;
  final String mainTitle;
  final String rate;
  final String reviews;
  final String totalSteps;
  final String currentStep;
  final List<ServiceCategoryModel> categories;
  final String promoCode;
  final String promoDiscount;
  final List<ServiceGroupModel> serviceGroups;

  const ServicePageModel({
    required this.coverImage,
    required this.mainTitle,
    required this.rate,
    required this.reviews,
    required this.totalSteps,
    required this.currentStep,
    required this.categories,
    required this.promoCode,
    required this.promoDiscount,
    required this.serviceGroups,
  });
}

