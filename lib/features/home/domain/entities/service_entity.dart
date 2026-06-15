import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String title;
  final String imagePath;
  final String? badge;
  final String? discount;

  const ServiceEntity({
    required this.title,
    required this.imagePath,
    this.badge,
    this.discount,
  });

  @override
  List<Object?> get props => [title, imagePath, badge, discount];
}
