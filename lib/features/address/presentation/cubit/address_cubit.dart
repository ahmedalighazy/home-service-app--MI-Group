import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/address/data/dummy/address_dummy_data.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit()
    : super(const AddressState(addresses: AddressDummyData.addresses));

  void selectAddress(int index) {
    final updatedAddresses = state.addresses
        .asMap()
        .entries
        .map((entry) => entry.value.copyWith(isSelected: entry.key == index))
        .toList();

    emit(state.copyWith(addresses: updatedAddresses));
  }
}
