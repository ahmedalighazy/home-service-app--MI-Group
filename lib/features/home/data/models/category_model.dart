import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.title, required super.iconPath});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'] ?? '',
      iconPath: json['icon_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'icon_path': iconPath};
  }
}
