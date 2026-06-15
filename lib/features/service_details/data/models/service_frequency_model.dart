import 'package:flutter/material.dart';

class ServiceFrequency {
  final String title;
  final String? badge;
  final String? discount;
  final Color? badgeColor;

  const ServiceFrequency({
    required this.title,
    this.badge,
    this.discount,
    this.badgeColor,
  });
}
