import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_text_field.dart';

class HomeAddressFields extends StatelessWidget {
  const HomeAddressFields({
    super.key,
    required this.streetController,
    required this.buildingController,
    required this.apartmentController,
    required this.floorController,
  });

  final TextEditingController streetController;
  final TextEditingController buildingController;
  final TextEditingController apartmentController;
  final TextEditingController floorController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressTextField(
          hintText: AppStrings.streetNameOrNumber,
          controller: streetController,
        ),

        SizedBox(height: AppSizes.spacingMedium),

        Row(
          children: [
            Expanded(
              child: AddressTextField(
                hintText: AppStrings.buildingNumber,
                controller: buildingController,
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: AddressTextField(
                hintText: AppStrings.apartmentNumber,
                controller: apartmentController,
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: AddressTextField(
                hintText: AppStrings.floorNumber,
                controller: floorController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
