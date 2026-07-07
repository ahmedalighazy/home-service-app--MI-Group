import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class CreateAddressUseCase {
  final AddressRepository _repository;

  CreateAddressUseCase(this._repository);

  Future<Either<Failure, AddressEntity>> call({
    required double longitude,
    required double latitude,
    required String type,
    String? description,
    String? label,
    String? streetName,
    String? notes,
    String? buildingNumber,
    String? apartmentNumber,
    String? floorNumber,
    bool isDefault = false,
  }) {
    return _repository.createAddress(
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

