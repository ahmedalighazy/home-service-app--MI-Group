import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class ServiceStepModel {
  final String title;
  final Widget content;
  final String nextLabel;
  // VoidCallback? onNext;
  // VoidCallback? onBack;

  ServiceStepModel({
    required this.title,
    required this.content,
    this.nextLabel = AppStrings.next,
    // required this.onNext,
    // required this.onBack,
  });
}

