import 'package:equatable/equatable.dart';

class ServiceAddonEntity extends Equatable {
  final String id;
  final String name;
  final String subtitle;
  final String image;
  final double price;

  const ServiceAddonEntity({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, subtitle, image, price];
}
