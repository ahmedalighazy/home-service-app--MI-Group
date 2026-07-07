import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class UpdateAddressUseCase {
  final AddressRepository _repository;

  UpdateAddressUseCase(this._repository);

  Future<Either<Failure, AddressEntity>> call({
    required String id,
    double? longitude,
    double? latitude,
    String? type,
    String? description,
    String? label,
    String? streetName,
    String? notes,
    String? buildingNumber,
    String? apartmentNumber,
    String? floorNumber,
    bool? isDefault,
  }) {
    return _repository.updateAddress(
      id: id,
      longitude: longitude,
      latitude: latitude,
      type: type,
      description: description,
      label: label,
      streetName: streetName,
      notes: notes,
      buildingNumber: buildingNumber,
      apartmentNumber: apartmentNumber,
      floorNumber: floorNumber,
      isDefault: isDefault,
    );
  }
}

