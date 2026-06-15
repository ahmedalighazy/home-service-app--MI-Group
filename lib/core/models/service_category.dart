import 'package:flutter/material.dart';

class ServiceCategory {
  final String id;
  final String title;
  final IconData icon;
  final Color? iconColor;

  ServiceCategory({
    required this.id,
    required this.title,
    required this.icon,
    this.iconColor,
  });
}
