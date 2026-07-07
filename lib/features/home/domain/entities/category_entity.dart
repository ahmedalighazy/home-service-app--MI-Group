import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String iconUrl;
  final String imageUrl;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, iconUrl, imageUrl];
}
