import 'package:home_service_app/features/service_details/data/models/service_item_model.dart';

class ServiceGroupModel {
  final String categoryTitle;
  final List<ServiceItemModel> items;

  const ServiceGroupModel({required this.categoryTitle, required this.items});
}
