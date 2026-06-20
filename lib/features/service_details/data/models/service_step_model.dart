import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

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
