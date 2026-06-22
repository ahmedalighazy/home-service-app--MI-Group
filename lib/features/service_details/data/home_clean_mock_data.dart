import 'package:flutter/material.dart';

import 'models/extra_item_model.dart';
import 'models/home_clean_question_model.dart';
import 'models/service_frequency_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class HomeCleanMockData {

  static List<HomeCleanQuestion> get questions => [
    HomeCleanQuestion(
      label: SdStrings.hourRegularCleaning,
      type: QuestionType.pill,
      options: [SdStrings.regular, SdStrings.regularWithCleaningAddOn],
    ),
    HomeCleanQuestion(
      label: SdStrings.hourRegularCleaning,
      type: QuestionType.pill,
      options: const ['1', '2', '3', '4', '5', '6', '7'],
      selectedOptionIndex: 3,
    ),
    HomeCleanQuestion(
      label: SdStrings.countRoomsKitchens,
      type: QuestionType.stepper,
      options: const [],
      selectedOptionIndex: 1,
    ),
    HomeCleanQuestion(
      label: SdStrings.sizePlace,
      type: QuestionType.pill,
      options: [SdStrings.studio, SdStrings.oneRoom, SdStrings.twoRooms, SdStrings.threeRooms, SdStrings.fourRooms],
      selectedOptionIndex: 1,
    ),
    HomeCleanQuestion(
      label: SdStrings.detailsFloors,
      type: QuestionType.pill,
      options: [SdStrings.ground, SdStrings.first, SdStrings.second, SdStrings.sports],
      selectedOptionIndex: 0,
    ),
  ];

  static List<ExtraItem> get extras => [
    ExtraItem(
      title: SdStrings.cleaningKitchen,
      price: 30,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.cleaningWindows,
      price: 25,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.cleaningBathroom,
      price: 20,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.polishingFloors,
      price: 35,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.washingCurtains,
      price: 40,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.cleaningOven,
      price: 28,
      image: 'assets/images/Rectangle 46.png',
    ),
  ];

  static final List<ServiceFrequency> frequencies = [
    ServiceFrequency(title: SdStrings.onceOne),
    ServiceFrequency(
      title: SdStrings.text20,
      badge: SdStrings.most,
      badgeColor: Color(0xff189AB4),
    ),
    ServiceFrequency(
      title: SdStrings.twoWeekly,
      discount: SdStrings.tenPercentDiscount,
      badgeColor: Color(0xff27AE60),
    ),
    ServiceFrequency(
      title: SdStrings.text132,
      discount: SdStrings.fivePercentDiscount,
      badgeColor: Color(0xff27AE60),
    ),
  ];
}
