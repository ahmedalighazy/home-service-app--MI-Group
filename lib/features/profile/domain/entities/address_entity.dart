import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final double longitude;
  final double latitude;
  final String type;
  final String? description;
  final String? label;
  final String? streetName;
  final String? notes;
  final String? buildingNumber;
  final String? apartmentNumber;
  final String? floorNumber;
  final bool isDefault;
  final String? userId;
  final String? userName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AddressEntity({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.type,
    this.description,
    this.label,
    this.streetName,
    this.notes,
    this.buildingNumber,
    this.apartmentNumber,
    this.floorNumber,
    this.isDefault = false,
    this.userId,
    this.userName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id];
}
