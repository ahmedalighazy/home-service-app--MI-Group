import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

/// Represents a saved delivery address.
class AddressModel {
  final String title;
  final String subtitle;
  final IconData icon;

  const AddressModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  /// Mock saved addresses shown on the Address step.
  static const List<AddressModel> savedAddresses = [
    AddressModel(
      title: AppStrings.home,
      subtitle: AppStrings.homeAddressSubtitle,
      icon: Icons.home_outlined,
    ),
    AddressModel(
      title: AppStrings.work,
      subtitle: AppStrings.workAddressSubtitle,
      icon: Icons.business_center_outlined,
    ),
  ];
}
