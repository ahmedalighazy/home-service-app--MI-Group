import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String title;
  final String iconPath;

  const CategoryEntity({required this.title, required this.iconPath});

  @override
  List<Object?> get props => [title, iconPath];
}
