import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class ServiceStepModel {
  final String title;
  final Widget content;
  final String nextLabel;

  ServiceStepModel({
    required this.title,
    required this.content,
    String? nextLabel,
  }) : nextLabel = nextLabel ?? SdStrings.next;
}
