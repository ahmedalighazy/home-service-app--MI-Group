import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class GetAddressesUseCase {
  final AddressRepository _repository;

  GetAddressesUseCase(this._repository);

  Future<Either<Failure, List<AddressEntity>>> call() {
    return _repository.getMyAddresses();
  }
}

