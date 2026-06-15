import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../data/models/corporate_place_type.dart';
import '../../../data/models/corporate_service_type.dart';
import 'corporate_choice_chip.dart';
import 'corporate_section_label.dart';
import 'corporate_submit_button.dart';
import 'corporate_text_field.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class CorporateFormCard extends StatelessWidget {
  final PlaceType placeType;
  final CorporateServiceType serviceType;
  final TextEditingController placeNameController;
  final TextEditingController locationController;
  final TextEditingController areaController;
  final TextEditingController detailsController;
  final ValueChanged<PlaceType> onPlaceTypeChanged;
  final ValueChanged<CorporateServiceType> onServiceTypeChanged;
  final ValueChanged<String> onPlaceNameChanged;
  final ValueChanged<String> onLocationChanged;
  final ValueChanged<String> onAreaChanged;
  final ValueChanged<String> onDetailsChanged;
  final VoidCallback onSubmit;

  const CorporateFormCard({
    super.key,
    required this.placeType,
    required this.serviceType,
    required this.placeNameController,
    required this.locationController,
    required this.areaController,
    required this.detailsController,
    required this.onPlaceTypeChanged,
    required this.onServiceTypeChanged,
    required this.onPlaceNameChanged,
    required this.onLocationChanged,
    required this.onAreaChanged,
    required this.onDetailsChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 18, 12, 14),
      decoration: BoxDecoration(
        color: const Color(0xffF7F8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CorporateSectionLabel(text: SdStrings.typePlace),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CorporateChoiceChip(
                label: SdStrings.mosque,
                isSelected: placeType == PlaceType.mosque,
                onTap: () => onPlaceTypeChanged(PlaceType.mosque),
              ),
              const SizedBox(width: 8),
              CorporateChoiceChip(
                label: SdStrings.company,
                isSelected: placeType == PlaceType.company,
                onTap: () => onPlaceTypeChanged(PlaceType.company),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CorporateTextField(
            label: SdStrings.namePlace,
            hintText: SdStrings.writeNameCompanyOrMosque,
            controller: placeNameController,
            onChanged: onPlaceNameChanged,
          ),
          const SizedBox(height: 16),
          CorporateTextField(
            label: SdStrings.addressLocation,
            hintText: SdStrings.writeLocationInDetail,
            controller: locationController,
            onChanged: onLocationChanged,
          ),
          const SizedBox(height: 16),
          CorporateTextField(
            label: SdStrings.areaPlace,
            hintText: SdStrings.areaPlace,
            controller: areaController,
            keyboardType: TextInputType.number,
            onChanged: onAreaChanged,
          ),
          const SizedBox(height: 18),
          CorporateSectionLabel(text: SdStrings.typeServiceRequired),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              CorporateChoiceChip(
                label: SdStrings.cleaningFull,
                isSelected: serviceType == CorporateServiceType.cleaning,
                onTap: () =>
                    onServiceTypeChanged(CorporateServiceType.cleaning),
              ),
              CorporateChoiceChip(
                label: SdStrings.pestControlPests,
                isSelected: serviceType == CorporateServiceType.pestControl,
                onTap: () =>
                    onServiceTypeChanged(CorporateServiceType.pestControl),
              ),
              CorporateChoiceChip(
                label: SdStrings.furniture,
                isSelected:
                    serviceType == CorporateServiceType.furnitureCleaning,
                onTap: () => onServiceTypeChanged(
                  CorporateServiceType.furnitureCleaning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CorporateTextField(
            label: SdStrings.detailsAdditionalOptional,
            hintText: SdStrings.writeAnyNotesHelpUsUnderstandYourNeed,
            controller: detailsController,
            maxLines: 3,
            onChanged: onDetailsChanged,
          ),
          const SizedBox(height: 8),
          Text('300/0', style: AppText.regular10Grey),
          const SizedBox(height: 12),
          CorporateSubmitButton(onTap: onSubmit),
        ],
      ),
    );
  }
}
