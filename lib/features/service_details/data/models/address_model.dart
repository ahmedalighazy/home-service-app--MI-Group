import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class AddressModel {
  final String title;
  final String subtitle;
  final IconData icon;

  const AddressModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static final List<AddressModel> savedAddresses = [
    AddressModel(
      title: SdStrings.home,
      subtitle: SdStrings.homeAddressSubtitle,
      icon: Icons.home_outlined,
    ),
    AddressModel(
      title: SdStrings.work,
      subtitle: SdStrings.workAddressSubtitle,
      icon: Icons.business_center_outlined,
    ),
  ];
}
