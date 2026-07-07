import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/update_address_usecase.dart';
import '../../domain/usecases/delete_address_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final CreateAddressUseCase _createAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  AddressCubit(
    this._getAddressesUseCase,
    this._createAddressUseCase,
    this._updateAddressUseCase,
    this._deleteAddressUseCase,
  ) : super(const AddressInitial());

  // ======================== Get Addresses =======================
  Future<void> getAddresses() async {
    emit(const AddressLoading());
    final result = await _getAddressesUseCase();
    result.fold(
      (failure) => emit(AddressError(failure.message)),
      (addresses) => emit(AddressesLoaded(addresses)),
    );
  }

  // ======================== Create Address =======================
  Future<void> createAddress({
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
    emit(const CreateAddressLoading());
    final result = await _createAddressUseCase(
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
    result.fold(
      (failure) => emit(CreateAddressError(failure.message)),
      (address) {
        emit(CreateAddressSuccess(address));
        getAddresses();
      },
    );
  }

  // ======================== Update Address =======================
  Future<void> updateAddress({
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
    emit(const UpdateAddressLoading());
    final result = await _updateAddressUseCase(
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
    result.fold(
      (failure) => emit(UpdateAddressError(failure.message)),
      (address) {
        emit(UpdateAddressSuccess(address));
        getAddresses();
      },
    );
  }

  // ======================== Delete Address =======================
  Future<void> deleteAddress(String id) async {
    emit(const DeleteAddressLoading());
    final result = await _deleteAddressUseCase(id);
    result.fold(
      (failure) => emit(DeleteAddressError(failure.message)),
      (_) {
        emit(const DeleteAddressSuccess());
        getAddresses();
      },
    );
  }
}
