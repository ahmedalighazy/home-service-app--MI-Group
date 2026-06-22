import '../repositories/address_repository.dart';

class SelectAddressUseCase {
  final AddressRepository repository;

  SelectAddressUseCase(this.repository);

  Future<void> call(String addressId) {
    return repository.selectAddress(addressId);
  }
}
