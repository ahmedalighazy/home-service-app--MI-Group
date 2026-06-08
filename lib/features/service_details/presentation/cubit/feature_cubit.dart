import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/corporate_place_type.dart';
import '../../data/models/corporate_service_type.dart';
import '../../data/models/payment_method.dart';
import '../../data/models/repeat_type.dart';
import 'feature_state.dart';


class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit() : super(const FeatureInitial()) {
    loadFeature();
  }

  FeatureLoaded get loadedState {
    final currentState = state;
    if (currentState is FeatureLoaded) return currentState;
    return const FeatureLoaded();
  }

  void loadFeature() {
    emit(const FeatureLoading());
    emit(const FeatureLoaded());
  }

  void resetFeature() {
    emit(const FeatureLoaded());
  }

  void failFeature(String message) {
    emit(FeatureError(message));
  }

  void selectServiceCategory(int index) {
    final current = loadedState;
    if (current.selectedServiceCategoryIndex == index) return;
    emit(current.copyWith(selectedServiceCategoryIndex: index));
  }

  void updateServiceItemQuantity({
    required String itemKey,
    required double price,
    required int quantity,
  }) {
    final current = loadedState;
    final quantities = Map<String, int>.from(current.serviceItemQuantities);
    final prices = Map<String, double>.from(current.serviceItemPrices);

    if (quantity <= 0) {
      quantities.remove(itemKey);
      prices.remove(itemKey);
    } else {
      quantities[itemKey] = quantity;
      prices[itemKey] = price;
    }

    emit(
      current.copyWith(
        serviceItemQuantities: quantities,
        serviceItemPrices: prices,
      ),
    );
  }

  void incrementServiceItem(String itemKey, double price) {
    final current = loadedState;
    updateServiceItemQuantity(
      itemKey: itemKey,
      price: price,
      quantity: current.serviceItemQuantity(itemKey) + 1,
    );
  }

  void decrementServiceItem(String itemKey, double price) {
    final current = loadedState;
    updateServiceItemQuantity(
      itemKey: itemKey,
      price: price,
      quantity: current.serviceItemQuantity(itemKey) - 1,
    );
  }

  void toggleServiceItemFavorite(String itemKey) {
    final current = loadedState;
    final favorites = Set<String>.from(current.favoriteServiceItemKeys);
    favorites.contains(itemKey)
        ? favorites.remove(itemKey)
        : favorites.add(itemKey);
    emit(current.copyWith(favoriteServiceItemKeys: favorites));
  }

  void toggleServiceCoverFavorite() {
    final current = loadedState;
    emit(
      current.copyWith(isServiceCoverFavorite: !current.isServiceCoverFavorite),
    );
  }

  void nextBookingStep(int maxIndex) {
    final current = loadedState;
    if (current.bookingStepIndex >= maxIndex) return;
    emit(current.copyWith(bookingStepIndex: current.bookingStepIndex + 1));
  }

  void previousBookingStep() {
    final current = loadedState;
    if (current.bookingStepIndex == 0) return;
    emit(current.copyWith(bookingStepIndex: current.bookingStepIndex - 1));
  }

  void resetBookingStepProgress() {
    emit(loadedState.copyWith(bookingStepIndex: 0));
  }

  void selectHours(int value) {
    emit(loadedState.copyWith(selectedHours: value));
  }

  void selectWorkers(int value) {
    emit(loadedState.copyWith(selectedWorkers: value));
  }

  void selectHomeSize(String value) {
    emit(loadedState.copyWith(selectedSize: value));
  }

  void selectWorkerGender(String value) {
    emit(loadedState.copyWith(selectedGender: value));
  }

  void updateExtraQuantity(String title, int quantity) {
    final current = loadedState;
    final quantities = Map<String, int>.from(current.extraQuantities);

    if (quantity <= 0) {
      quantities.remove(title);
    } else {
      quantities[title] = quantity;
    }

    emit(current.copyWith(extraQuantities: quantities));
  }

  void incrementExtra(String title) {
    final current = loadedState;
    updateExtraQuantity(title, current.extraQuantity(title) + 1);
  }

  void decrementExtra(String title) {
    final current = loadedState;
    updateExtraQuantity(title, current.extraQuantity(title) - 1);
  }

  void selectRepeatType(RepeatType type) {
    emit(loadedState.copyWith(repeatType: type));
  }

  void selectDay(int index) {
    emit(loadedState.copyWith(selectedDayIndex: index));
  }

  void selectTimeSlot(int index) {
    emit(loadedState.copyWith(selectedSlotIndex: index));
  }

  void selectAddress(int index) {
    emit(loadedState.copyWith(selectedAddressIndex: index));
  }

  void selectPaymentMethod(PaymentMethod method) {
    emit(loadedState.copyWith(paymentMethod: method));
  }

  void selectSavedCard(int index) {
    emit(loadedState.copyWith(selectedCardIndex: index));
  }

  void updatePromoCode(String value) {
    emit(loadedState.copyWith(promoCode: value));
  }

  void setBookingSuccessful(bool value) {
    emit(loadedState.copyWith(isBookingSuccessful: value));
  }

  void toggleCorporateFavorite() {
    final current = loadedState;
    emit(current.copyWith(isCorporateFavorite: !current.isCorporateFavorite));
  }

  void selectCorporatePlaceType(PlaceType value) {
    emit(loadedState.copyWith(corporatePlaceType: value));
  }

  void selectCorporateServiceType(CorporateServiceType value) {
    emit(loadedState.copyWith(corporateServiceType: value));
  }

  void updateCorporatePlaceName(String value) {
    emit(loadedState.copyWith(corporatePlaceName: value));
  }

  void updateCorporateLocation(String value) {
    emit(loadedState.copyWith(corporateLocation: value));
  }

  void updateCorporateArea(String value) {
    emit(loadedState.copyWith(corporateArea: value));
  }

  void updateCorporateDetails(String value) {
    emit(loadedState.copyWith(corporateDetails: value));
  }

  void updateTeamRating(int value) {
    emit(loadedState.copyWith(teamRating: value));
  }

  void updateServiceRating(int value) {
    emit(loadedState.copyWith(serviceRating: value));
  }

  void updateTeamComment(String value) {
    emit(loadedState.copyWith(teamComment: value));
  }

  void updateServiceComment(String value) {
    emit(loadedState.copyWith(serviceComment: value));
  }
}

