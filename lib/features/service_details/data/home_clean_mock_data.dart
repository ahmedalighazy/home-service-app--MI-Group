import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import 'models/extra_item_model.dart';
import 'models/home_clean_question_model.dart';
import 'models/service_frequency_model.dart';

class HomeCleanMockData {
  // Step 1: Requirements questions

  static List<HomeCleanQuestion> get questions => [
    HomeCleanQuestion(
      label: AppStrings.howManyHours,
      type: QuestionType.pill,
      options: const [AppStrings.regular, AppStrings.regularWithCleaningAddOn],
    ),
    HomeCleanQuestion(
      label: AppStrings.howManyHours,
      type: QuestionType.pill,
      options: const ['1', '2', '3', '4', '5', '6', '7'],
      selectedOptionIndex: 3,
    ),
    HomeCleanQuestion(
      label: AppStrings.countRoomsKitchens,
      type: QuestionType.stepper,
      options: const [],
      selectedOptionIndex: 1,
    ),
    HomeCleanQuestion(
      label: AppStrings.placeSize,
      type: QuestionType.pill,
      options: const [
        AppStrings.studio,
        AppStrings.oneRoom,
        AppStrings.twoRooms,
        AppStrings.threeRooms,
        AppStrings.fourRooms,
      ],
      selectedOptionIndex: 1,
    ),
    HomeCleanQuestion(
      label: AppStrings.detailsFloors,
      type: QuestionType.pill,
      options: const [
        AppStrings.ground,
        AppStrings.first,
        AppStrings.second,
        AppStrings.sports,
      ],
      selectedOptionIndex: 0,
    ),
  ];

  // Step 2: Extras

  static List<ExtraItem> get extras => [
    ExtraItem(
      title: AppStrings.cleaningKitchen,
      price: 30,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.cleaningWindows,
      price: 25,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.cleaningBathroom,
      price: 20,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.polishingFloors,
      price: 35,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.washingCurtains,
      price: 40,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.cleaningOven,
      price: 28,
      image: 'assets/images/Rectangle 46.png',
    ),
  ];

  //Step 3: Service frequency

  static List<ServiceFrequency> frequencies = [
    ServiceFrequency(title: AppStrings.once),
    ServiceFrequency(
      title: AppStrings.weekly,
      badge: AppStrings.mostRequested,
      badgeColor: AppColors.greenPrimary,
    ),
    ServiceFrequency(
      title: AppStrings.twoWeeks,
      discount: AppStrings.discountUpTo10,
      badgeColor: AppColors.greenLight,
    ),
    ServiceFrequency(
      title: AppStrings.monthly,
      discount: AppStrings.fivePercentDiscount,
      badgeColor: AppColors.greenLight,
    ),
  ];
}
