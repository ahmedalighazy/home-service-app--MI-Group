import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getMyAddresses();

  Future<Either<Failure, AddressEntity>> getAddressById(String id);

  Future<Either<Failure, AddressEntity>> createAddress({
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
  });

  Future<Either<Failure, AddressEntity>> updateAddress({
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
  });

  Future<Either<Failure, void>> deleteAddress(String id);
}
