import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_text_field.dart';

class WorkAddressFields extends StatelessWidget {
  const WorkAddressFields({
    super.key,
    required this.companyController,
    required this.buildingController,
    required this.officeController,
  });

  final TextEditingController companyController;
  final TextEditingController buildingController;
  final TextEditingController officeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressTextField(
          hintText: context.l10n.companyName,
          controller: companyController,
        ),

        SizedBox(height: AppSizes.spacingMedium),

        Row(
          children: [
            Expanded(
              child: AddressTextField(
                hintText: context.l10n.buildingNumber,
                controller: buildingController,
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: AddressTextField(
                hintText: context.l10n.officeOrFloorNumber,
                controller: officeController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
