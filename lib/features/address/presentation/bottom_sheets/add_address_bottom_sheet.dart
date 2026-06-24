import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_text_field.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_type_selector.dart';
import 'package:home_service_app/features/address/presentation/widgets/bottom_sheet_handle.dart';
import 'package:home_service_app/features/address/presentation/widgets/home_address_fields.dart';
import 'package:home_service_app/features/address/presentation/widgets/work_address_fields.dart';

class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({super.key});

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  bool isWorkSelected = true;

  final companyController = TextEditingController();
  final buildingController = TextEditingController();
  final officeController = TextEditingController();

  final apartmentController = TextEditingController();
  final floorController = TextEditingController();

  final notesController = TextEditingController();

  @override
  void dispose() {
    companyController.dispose();
    buildingController.dispose();
    officeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXLarge),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BottomSheetHandle(),

              SizedBox(height: AppSizes.spacingLarge),

              Text(
                context.tr(LocaleKeys.addNewAddress),
                style: AppText.ibmPlexSansArabic16SemiBold,
              ),

              SizedBox(height: AppSizes.spacingLarge),

              Row(
                children: [
                  AddressTypeSelector(
                    title: context.tr(LocaleKeys.addressWork),
                    iconsPath: IconsPath.institutionsIcon,
                    isSelected: isWorkSelected,
                    onTap: () {
                      setState(() {
                        isWorkSelected = true;
                      });
                    },
                  ),

                  SizedBox(width: AppSizes.spacingMedium),

                  AddressTypeSelector(
                    iconsPath: IconsPath.home,
                    title: context.tr(LocaleKeys.addressHome),
                    isSelected: !isWorkSelected,
                    onTap: () {
                      setState(() {
                        isWorkSelected = false;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: AppSizes.spacingLarge),

              isWorkSelected
                  ? WorkAddressFields(
                      companyController: companyController,
                      buildingController: buildingController,
                      officeController: officeController,
                    )
                  : HomeAddressFields(
                      streetController: companyController,
                      buildingController: buildingController,
                      apartmentController: apartmentController,
                      floorController: floorController,
                    ),
              SizedBox(height: AppSizes.spacingMedium),

              AddressTextField(
                hintText: context.tr(LocaleKeys.additionalNotes),
                controller: notesController,
                maxLines: 1,
              ),

              SizedBox(height: AppSizes.spacingXLarge),

              CustomButtom(
                text: context.tr(LocaleKeys.saveAddress),
                startColor: AppColors.greenPrimary,
                endColor: AppColors.greenPrimary,
                textStyle: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
