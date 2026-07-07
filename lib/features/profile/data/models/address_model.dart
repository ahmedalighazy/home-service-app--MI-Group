import '../../domain/entities/address_entity.dart';

class AddressModel {
  final String? id;
  final double? longitude;
  final double? latitude;
  final String? type;
  final String? description;
  final String? label;
  final String? streetName;
  final String? notes;
  final String? buildingNumber;
  final String? apartmentNumber;
  final String? floorNumber;
  final bool? isDefault;
  final String? userId;
  final String? userName;
  final String? createdAt;
  final String? updatedAt;

  const AddressModel({
    this.id,
    this.longitude,
    this.latitude,
    this.type,
    this.description,
    this.label,
    this.streetName,
    this.notes,
    this.buildingNumber,
    this.apartmentNumber,
    this.floorNumber,
    this.isDefault,
    this.userId,
    this.userName,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      type: json['type'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      streetName: json['streetName'] as String?,
      notes: json['notes'] as String?,
      buildingNumber: json['buildingNumber'] as String?,
      apartmentNumber: json['apartmentNumber'] as String?,
      floorNumber: json['floorNumber'] as String?,
      isDefault: json['isDefault'] as bool?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['type'] = type;
    map['description'] = description;
    map['label'] = label;
    map['streetName'] = streetName;
    map['notes'] = notes;
    map['buildingNumber'] = buildingNumber;
    map['apartmentNumber'] = apartmentNumber;
    map['floorNumber'] = floorNumber;
    map['isDefault'] = isDefault;
    map['userId'] = userId;
    map['userName'] = userName;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      longitude: longitude ?? 0.0,
      latitude: latitude ?? 0.0,
      type: type ?? 'HOME',
      description: description,
      label: label,
      streetName: streetName,
      notes: notes,
      buildingNumber: buildingNumber,
      apartmentNumber: apartmentNumber,
      floorNumber: floorNumber,
      isDefault: isDefault ?? false,
      userId: userId,
      userName: userName,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }
}
