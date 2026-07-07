class CreateAddressRequest {
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

  const CreateAddressRequest({
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
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'longitude': longitude,
      'latitude': latitude,
      'type': type,
      'isDefault': isDefault,
    };
    if (description != null) map['description'] = description;
    if (label != null) map['label'] = label;
    if (streetName != null) map['streetName'] = streetName;
    if (notes != null) map['notes'] = notes;
    if (buildingNumber != null) map['buildingNumber'] = buildingNumber;
    if (apartmentNumber != null) map['apartmentNumber'] = apartmentNumber;
    if (floorNumber != null) map['floorNumber'] = floorNumber;
    return map;
  }
}

class UpdateAddressRequest {
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

  const UpdateAddressRequest({
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
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (longitude != null) map['longitude'] = longitude;
    if (latitude != null) map['latitude'] = latitude;
    if (type != null) map['type'] = type;
    if (description != null) map['description'] = description;
    if (label != null) map['label'] = label;
    if (streetName != null) map['streetName'] = streetName;
    if (notes != null) map['notes'] = notes;
    if (buildingNumber != null) map['buildingNumber'] = buildingNumber;
    if (apartmentNumber != null) map['apartmentNumber'] = apartmentNumber;
    if (floorNumber != null) map['floorNumber'] = floorNumber;
    if (isDefault != null) map['isDefault'] = isDefault;
    return map;
  }
}
