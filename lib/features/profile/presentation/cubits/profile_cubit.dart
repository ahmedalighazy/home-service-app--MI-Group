import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/get_subscriptions_usecase.dart';
import '../../domain/usecases/get_visits_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/repositories/profile_repository.dart';
import '../states/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetAddressesUseCase getAddressesUseCase;
  final GetSubscriptionsUseCase getSubscriptionsUseCase;
  final GetVisitsUseCase getVisitsUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final ProfileRepository profileRepository;

  ProfileCubit({
    required this.getAddressesUseCase,
    required this.getSubscriptionsUseCase,
    required this.getVisitsUseCase,
    required this.updateProfileUseCase,
    required this.profileRepository,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {

      emit(ProfileLoaded({}));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfileData(Map<String, dynamic> profileData) async {
    emit(ProfileLoading());
    try {
      await updateProfileUseCase(profileData);
      emit(ProfileLoaded(profileData));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    try {
      await profileRepository.deleteAccount();
      emit(ProfileLoaded({}));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> loadAddresses() async {
    emit(AddressesLoading());
    try {
      final addresses = await getAddressesUseCase();
      emit(AddressesLoaded(addresses));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> addAddress(AddressEntity address) async {
    try {
      await profileRepository.addAddress(address);
      await loadAddresses();
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> updateAddress(AddressEntity address) async {
    try {
      await profileRepository.updateAddress(address);
      await loadAddresses();
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await profileRepository.deleteAddress(addressId);
      await loadAddresses();
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    try {
      await profileRepository.setDefaultAddress(addressId);
      await loadAddresses();
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> loadPaymentMethods() async {
    emit(PaymentMethodsLoading());
    try {
      final paymentMethods = await profileRepository.getPaymentMethods();
      emit(PaymentMethodsLoaded(paymentMethods));
    } catch (e) {
      emit(PaymentMethodsError(e.toString()));
    }
  }

  Future<void> addPaymentMethod(PaymentMethodEntity paymentMethod) async {
    try {
      await profileRepository.addPaymentMethod(paymentMethod);
      await loadPaymentMethods();
    } catch (e) {
      emit(PaymentMethodsError(e.toString()));
    }
  }

  Future<void> deletePaymentMethod(String paymentMethodId) async {
    try {
      await profileRepository.deletePaymentMethod(paymentMethodId);
      await loadPaymentMethods();
    } catch (e) {
      emit(PaymentMethodsError(e.toString()));
    }
  }

  Future<void> setDefaultPaymentMethod(String paymentMethodId) async {
    try {
      await profileRepository.setDefaultPaymentMethod(paymentMethodId);
      await loadPaymentMethods();
    } catch (e) {
      emit(PaymentMethodsError(e.toString()));
    }
  }

  Future<void> loadSubscriptions() async {
    emit(SubscriptionsLoading());
    try {
      final subscriptions = await getSubscriptionsUseCase();
      emit(SubscriptionsLoaded(subscriptions));
    } catch (e) {
      emit(SubscriptionsError(e.toString()));
    }
  }

  Future<void> cancelSubscription(String subscriptionId) async {
    try {
      await profileRepository.cancelSubscription(subscriptionId);
      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionsError(e.toString()));
    }
  }

  Future<void> loadVisits() async {
    emit(VisitsLoading());
    try {
      final visits = await getVisitsUseCase();
      emit(VisitsLoaded(visits));
    } catch (e) {
      emit(VisitsError(e.toString()));
    }
  }
}
