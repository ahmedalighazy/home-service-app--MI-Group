import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../data/models/corporate_place_type.dart';
import '../../../data/models/corporate_service_type.dart';
import 'corporate_choice_chip.dart';
import 'corporate_section_label.dart';
import 'corporate_submit_button.dart';
import 'corporate_text_field.dart';

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
          CorporateSectionLabel(text: context.l10n.typePlace),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CorporateChoiceChip(
                label: context.l10n.mosque,
                isSelected: placeType == PlaceType.mosque,
                onTap: () => onPlaceTypeChanged(PlaceType.mosque),
              ),
              const SizedBox(width: 8),
              CorporateChoiceChip(
                label: context.l10n.company,
                isSelected: placeType == PlaceType.company,
                onTap: () => onPlaceTypeChanged(PlaceType.company),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CorporateTextField(
            label: context.l10n.namePlace,
            hintText: context.l10n.writeNameCompanyOrMosque,
            controller: placeNameController,
            onChanged: onPlaceNameChanged,
          ),
          const SizedBox(height: 16),
          CorporateTextField(
            label: context.l10n.addressLocation,
            hintText: context.l10n.writeLocationInDetail,
            controller: locationController,
            onChanged: onLocationChanged,
          ),
          const SizedBox(height: 16),
          CorporateTextField(
            label: context.l10n.areaPlace,
            hintText: context.l10n.areaPlace,
            controller: areaController,
            keyboardType: TextInputType.number,
            onChanged: onAreaChanged,
          ),
          const SizedBox(height: 18),
          CorporateSectionLabel(text: context.l10n.serviceType),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              CorporateChoiceChip(
                label: context.l10n.cleaningFull,
                isSelected: serviceType == CorporateServiceType.cleaning,
                onTap: () =>
                    onServiceTypeChanged(CorporateServiceType.cleaning),
              ),
              CorporateChoiceChip(
                label: context.l10n.pestControlPests,
                isSelected: serviceType == CorporateServiceType.pestControl,
                onTap: () =>
                    onServiceTypeChanged(CorporateServiceType.pestControl),
              ),
              CorporateChoiceChip(
                label: context.l10n.furniture,
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
            label: context.l10n.detailsAdditionalOptional,
            hintText: context.l10n.writeAnyNotesHelpUsUnderstandYourNeed,
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
