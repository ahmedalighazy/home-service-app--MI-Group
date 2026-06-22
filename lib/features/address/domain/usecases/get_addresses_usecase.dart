import '../../../profile/domain/entities/address_entity.dart';
import '../repositories/address_repository.dart';

class GetAddressesUseCase {
  final AddressRepository repository;

  GetAddressesUseCase(this.repository);

  Future<List<AddressEntity>> call() {
    return repository.getAddresses();
  }
}
