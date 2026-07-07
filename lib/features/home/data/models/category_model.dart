import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;
  final String iconUrl;
  final String imageUrl;

  final String slug;
  final String seoTitle;
  final String seoDescription;
  final String seoKeywords;
  final String? parentId;
  final String? parentName;
  final DateTime? createdAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.imageUrl,
    required this.slug,
    required this.seoTitle,
    required this.seoDescription,
    required this.seoKeywords,
    this.parentId,
    this.parentName,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      seoTitle: json['seoTitle'] ?? '',
      seoDescription: json['seoDescription'] ?? '',
      seoKeywords: json['seoKeywords'] ?? '',
      parentId: json['parentId'],
      parentName: json['parentName'],
      imageUrl: json['imageUrl'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      iconUrl: iconUrl,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'seoTitle': seoTitle,
      'seoDescription': seoDescription,
      'seoKeywords': seoKeywords,
      'parentId': parentId,
      'parentName': parentName,
      'imageUrl': imageUrl,
      'iconUrl': iconUrl,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
