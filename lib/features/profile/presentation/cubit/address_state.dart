part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

final class AddressInitial extends AddressState {
  const AddressInitial();
}

// ================= Get Addresses =================
final class AddressLoading extends AddressState {
  const AddressLoading();
}

final class AddressesLoaded extends AddressState {
  final List<AddressEntity> addresses;
  const AddressesLoaded(this.addresses);

  @override
  List<Object?> get props => [addresses];
}

final class AddressError extends AddressState {
  final String message;
  const AddressError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Create Address =================
final class CreateAddressLoading extends AddressState {
  const CreateAddressLoading();
}

final class CreateAddressSuccess extends AddressState {
  final AddressEntity address;
  const CreateAddressSuccess(this.address);

  @override
  List<Object?> get props => [address];
}

final class CreateAddressError extends AddressState {
  final String message;
  const CreateAddressError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Update Address =================
final class UpdateAddressLoading extends AddressState {
  const UpdateAddressLoading();
}

final class UpdateAddressSuccess extends AddressState {
  final AddressEntity address;
  const UpdateAddressSuccess(this.address);

  @override
  List<Object?> get props => [address];
}

final class UpdateAddressError extends AddressState {
  final String message;
  const UpdateAddressError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Delete Address =================
final class DeleteAddressLoading extends AddressState {
  const DeleteAddressLoading();
}

final class DeleteAddressSuccess extends AddressState {
  const DeleteAddressSuccess();
}

final class DeleteAddressError extends AddressState {
  final String message;
  const DeleteAddressError(this.message);

  @override
  List<Object?> get props => [message];
}
