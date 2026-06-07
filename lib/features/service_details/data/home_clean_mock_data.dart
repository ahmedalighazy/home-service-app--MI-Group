import 'package:flutter/material.dart';

import 'models/extra_item_model.dart';
import 'models/home_clean_question_model.dart';
import 'models/service_frequency_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';



class HomeCleanMockData {
  // Step 1: Requirements questions

  static List<HomeCleanQuestion> get questions => [
    HomeCleanQuestion(
      label: AppStrings.hourRegularCleaning,
      type: QuestionType.pill,
      options: const [AppStrings.regular, AppStrings.regularWithCleaningAddOn],
    ),
    HomeCleanQuestion(
      label: AppStrings.hourRegularCleaning,
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
      label: AppStrings.sizePlace,
      type: QuestionType.pill,
      options: const [AppStrings.studio, AppStrings.oneRoom, AppStrings.twoRooms, AppStrings.threeRooms, AppStrings.fourRooms],
      selectedOptionIndex: 1,
    ),
    HomeCleanQuestion(
      label: AppStrings.detailsFloors,
      type: QuestionType.pill,
      options: const [AppStrings.ground, AppStrings.first, AppStrings.second, AppStrings.sports],
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

  static const List<ServiceFrequency> frequencies = [
    ServiceFrequency(title: AppStrings.onceOne),
    ServiceFrequency(
      title: AppStrings.text20,
      badge: AppStrings.most,
      badgeColor: Color(0xff189AB4),
    ),
    ServiceFrequency(
      title: AppStrings.twoWeekly,
      discount: AppStrings.tenPercentDiscount,
      badgeColor: Color(0xff27AE60),
    ),
    ServiceFrequency(
      title: AppStrings.text132,
      discount: AppStrings.fivePercentDiscount,
      badgeColor: Color(0xff27AE60),
    ),
  ];
}

