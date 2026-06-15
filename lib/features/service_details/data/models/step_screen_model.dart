import 'package:flutter/material.dart';

class StepScreenModel {
  final String title;
  final Widget content;
  final double total;
  final VoidCallback? onNext;

  const StepScreenModel({
    required this.title,
    required this.content,
    required this.total,
    this.onNext,
  });
}
