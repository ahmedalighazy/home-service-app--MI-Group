import 'package:flutter/foundation.dart';

import '../../data/models/corporate_place_type.dart';
import '../../data/models/corporate_service_type.dart';
import '../../data/models/extra_item_model.dart';
import '../../data/models/payment_method.dart';
import '../../data/models/repeat_type.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

@immutable
sealed class FeatureState {
  const FeatureState();
}

final class FeatureInitial extends FeatureState {
  const FeatureInitial();
}

final class FeatureLoading extends FeatureState {
  const FeatureLoading();
}

final class FeatureError extends FeatureState {
  final String message;

  const FeatureError(this.message);
}

final class FeatureLoaded extends FeatureState {
  final int selectedServiceCategoryIndex;
  final Map<String, int> serviceItemQuantities;
  final Map<String, double> serviceItemPrices;
  final Set<String> favoriteServiceItemKeys;
  final bool isServiceCoverFavorite;
  final int bookingStepIndex;
  final int selectedHours;
  final int selectedWorkers;
  final String selectedSize;
  final String selectedGender;
  final Map<String, int> extraQuantities;
  final RepeatType repeatType;
  final int selectedDayIndex;
  final int selectedSlotIndex;
  final int selectedAddressIndex;
  final PaymentMethod paymentMethod;
  final int selectedCardIndex;
  final String promoCode;
  final bool isBookingSuccessful;
  final bool isCorporateFavorite;
  final PlaceType corporatePlaceType;
  final CorporateServiceType corporateServiceType;
  final String corporatePlaceName;
  final String corporateLocation;
  final String corporateArea;
  final String corporateDetails;
  final int teamRating;
  final int serviceRating;
  final String teamComment;
  final String serviceComment;

  const FeatureLoaded({
    this.selectedServiceCategoryIndex = 0,
    this.serviceItemQuantities = const {},
    this.serviceItemPrices = const {},
    this.favoriteServiceItemKeys = const {},
    this.isServiceCoverFavorite = false,
    this.bookingStepIndex = 0,
    this.selectedHours = 1,
    this.selectedWorkers = 1,
    this.selectedSize = 'apartmentSmall',
    this.selectedGender = 'female',
    this.extraQuantities = const {},
    this.repeatType = RepeatType.once,
    this.selectedDayIndex = 0,
    this.selectedSlotIndex = -1,
    this.selectedAddressIndex = 0,
    this.paymentMethod = PaymentMethod.cash,
    this.selectedCardIndex = 0,
    this.promoCode = '',
    this.isBookingSuccessful = true,
    this.isCorporateFavorite = false,
    this.corporatePlaceType = PlaceType.company,
    this.corporateServiceType = CorporateServiceType.cleaning,
    this.corporatePlaceName = '',
    this.corporateLocation = '',
    this.corporateArea = '',
    this.corporateDetails = '',
    this.teamRating = 4,
    this.serviceRating = 3,
    this.teamComment = '',
    this.serviceComment = '',
  });

  bool get hasServiceCartItems => serviceCartTotal > 0;

  double get serviceCartTotal {
    return serviceItemQuantities.entries.fold(0, (total, entry) {
      final price = serviceItemPrices[entry.key] ?? 0;
      return total + (price * entry.value);
    });
  }

  double get extrasTotal {
    return ExtraItem.catalogue.fold(0, (total, extra) {
      return total + extra.price * extraQuantity(extra.title);
    });
  }

  int serviceItemQuantity(String itemKey) =>
      serviceItemQuantities[itemKey] ?? 0;

  bool isServiceItemFavorite(String itemKey) {
    return favoriteServiceItemKeys.contains(itemKey);
  }

  int extraQuantity(String title) => extraQuantities[title] ?? 0;

  double bookingTotal(double baseTotal) => baseTotal + extrasTotal;

  List<ExtraItem> get selectedExtras {
    return ExtraItem.catalogue
        .map(
          (extra) => ExtraItem(
            title: extra.title,
            price: extra.price,
            image: extra.image,
            quantity: extraQuantity(extra.title),
          ),
        )
        .where((extra) => extra.quantity > 0)
        .toList();
  }

  FeatureLoaded copyWith({
    int? selectedServiceCategoryIndex,
    Map<String, int>? serviceItemQuantities,
    Map<String, double>? serviceItemPrices,
    Set<String>? favoriteServiceItemKeys,
    bool? isServiceCoverFavorite,
    int? bookingStepIndex,
    int? selectedHours,
    int? selectedWorkers,
    String? selectedSize,
    String? selectedGender,
    Map<String, int>? extraQuantities,
    RepeatType? repeatType,
    int? selectedDayIndex,
    int? selectedSlotIndex,
    int? selectedAddressIndex,
    PaymentMethod? paymentMethod,
    int? selectedCardIndex,
    String? promoCode,
    bool? isBookingSuccessful,
    bool? isCorporateFavorite,
    PlaceType? corporatePlaceType,
    CorporateServiceType? corporateServiceType,
    String? corporatePlaceName,
    String? corporateLocation,
    String? corporateArea,
    String? corporateDetails,
    int? teamRating,
    int? serviceRating,
    String? teamComment,
    String? serviceComment,
  }) {
    return FeatureLoaded(
      selectedServiceCategoryIndex:
          selectedServiceCategoryIndex ?? this.selectedServiceCategoryIndex,
      serviceItemQuantities:
          serviceItemQuantities ?? this.serviceItemQuantities,
      serviceItemPrices: serviceItemPrices ?? this.serviceItemPrices,
      favoriteServiceItemKeys:
          favoriteServiceItemKeys ?? this.favoriteServiceItemKeys,
      isServiceCoverFavorite:
          isServiceCoverFavorite ?? this.isServiceCoverFavorite,
      bookingStepIndex: bookingStepIndex ?? this.bookingStepIndex,
      selectedHours: selectedHours ?? this.selectedHours,
      selectedWorkers: selectedWorkers ?? this.selectedWorkers,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedGender: selectedGender ?? this.selectedGender,
      extraQuantities: extraQuantities ?? this.extraQuantities,
      repeatType: repeatType ?? this.repeatType,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      selectedSlotIndex: selectedSlotIndex ?? this.selectedSlotIndex,
      selectedAddressIndex: selectedAddressIndex ?? this.selectedAddressIndex,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      selectedCardIndex: selectedCardIndex ?? this.selectedCardIndex,
      promoCode: promoCode ?? this.promoCode,
      isBookingSuccessful: isBookingSuccessful ?? this.isBookingSuccessful,
      isCorporateFavorite: isCorporateFavorite ?? this.isCorporateFavorite,
      corporatePlaceType: corporatePlaceType ?? this.corporatePlaceType,
      corporateServiceType: corporateServiceType ?? this.corporateServiceType,
      corporatePlaceName: corporatePlaceName ?? this.corporatePlaceName,
      corporateLocation: corporateLocation ?? this.corporateLocation,
      corporateArea: corporateArea ?? this.corporateArea,
      corporateDetails: corporateDetails ?? this.corporateDetails,
      teamRating: teamRating ?? this.teamRating,
      serviceRating: serviceRating ?? this.serviceRating,
      teamComment: teamComment ?? this.teamComment,
      serviceComment: serviceComment ?? this.serviceComment,
    );
  }
}
