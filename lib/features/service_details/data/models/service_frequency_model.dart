import 'package:flutter/material.dart';


/// A bookable service frequency option shown on the Frequency step.
class ServiceFrequency {
  final String title;
  final String? badge; // e.g. AppStrings.most
  final String? discount; // e.g. AppStrings.tenPercentDiscount
  final Color? badgeColor;

  const ServiceFrequency({
    required this.title,
    this.badge,
    this.discount,
    this.badgeColor,
  });
}

