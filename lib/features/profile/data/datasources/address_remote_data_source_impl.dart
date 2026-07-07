import '../../../../core/network/api_service.dart';
import '../models/address_model.dart';
import '../models/address_paginated_response.dart';
import '../models/address_request.dart';
import 'address_remote_data_source.dart';

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final ApiService _apiService;

  AddressRemoteDataSourceImpl(this._apiService);

  @override
  Future<AddressPaginatedResponse> getMyAddresses() {
    return _apiService.getMyAddresses();
  }

  @override
  Future<AddressModel> getAddressById(String id) {
    return _apiService.getAddressById(id);
  }

  @override
  Future<AddressModel> createAddress(CreateAddressRequest request) {
    return _apiService.createAddress(request);
  }

  @override
  Future<AddressModel> updateAddress(String id, UpdateAddressRequest request) {
    return _apiService.updateAddress(id, request);
  }

  @override
  Future<void> deleteAddress(String id) {
    return _apiService.deleteAddress(id);
  }
}

