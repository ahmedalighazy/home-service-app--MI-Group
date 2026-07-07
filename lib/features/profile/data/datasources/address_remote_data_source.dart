import '../models/address_model.dart';
import '../models/address_paginated_response.dart';
import '../models/address_request.dart';

abstract class AddressRemoteDataSource {
  Future<AddressPaginatedResponse> getMyAddresses();

  Future<AddressModel> getAddressById(String id);

  Future<AddressModel> createAddress(CreateAddressRequest request);

  Future<AddressModel> updateAddress(String id, UpdateAddressRequest request);

  Future<void> deleteAddress(String id);
}
