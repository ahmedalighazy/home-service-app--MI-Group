import 'package:equatable/equatable.dart';
import 'package:home_service_app/features/address/domain/entities/address_entity.dart';

class AddressState extends Equatable {
  final List<AddressEntity> addresses;

  const AddressState({this.addresses = const []});

  AddressState copyWith({List<AddressEntity>? addresses}) {
    return AddressState(addresses: addresses ?? this.addresses);
  }

  @override
  List<Object?> get props => [addresses];
}
