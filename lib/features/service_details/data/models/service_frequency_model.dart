import 'package:flutter/material.dart';

/// A bookable service frequency option shown on the Frequency step.
class ServiceFrequency {
  final String title;
  final String? badge; // e.g. context.l10n.most
  final String? discount; // e.g. context.l10n.tenPercentDiscount
  final Color? badgeColor;

  const ServiceFrequency({
    required this.title,
    this.badge,
    this.discount,
    this.badgeColor,
  });
}
