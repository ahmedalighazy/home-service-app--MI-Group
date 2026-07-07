import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasources/address_remote_data_source.dart';
import '../models/address_request.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource _remoteDataSource;

  AddressRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AddressEntity>>> getMyAddresses() async {
    try {
      final response = await _remoteDataSource.getMyAddresses();
      final addresses =
          response.content.map((e) => e.toEntity()).toList();
      return Right(addresses);
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> getAddressById(String id) async {
    try {
      final response = await _remoteDataSource.getAddressById(id);
      return Right(response.toEntity());
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
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
  }) async {
    try {
      final request = CreateAddressRequest(
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
      final response = await _remoteDataSource.createAddress(request);
      return Right(response.toEntity());
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
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
  }) async {
    try {
      final request = UpdateAddressRequest(
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
      final response = await _remoteDataSource.updateAddress(id, request);
      return Right(response.toEntity());
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String id) async {
    try {
      await _remoteDataSource.deleteAddress(id);
      return const Right(null);
    } catch (e) {
      final apiError = ErrorHandler.handle(e);
      return Left(ServerFailure(apiError.message ?? 'Unknown error occurred'));
    }
  }
}

