import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_text_field.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_type_selector.dart';
import 'package:home_service_app/features/address/presentation/widgets/bottom_sheet_handle.dart';
import 'package:home_service_app/features/address/presentation/widgets/home_address_fields.dart';
import 'package:home_service_app/features/address/presentation/widgets/work_address_fields.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';

class AddAddressBottomSheet extends StatefulWidget {
  final AddressModel? address;
  final bool isEdit;

  const AddAddressBottomSheet({
    super.key,
    this.address,
    this.isEdit = false,
  });

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  late bool isWorkSelected;

  final companyController = TextEditingController();
  final buildingController = TextEditingController();
  final officeController = TextEditingController();

  final streetController = TextEditingController();
  final apartmentController = TextEditingController();
  final floorController = TextEditingController();

  final notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isWorkSelected = widget.address == null || widget.address!.label == AppStrings.addressWork;
    
    if (widget.address != null) {
      notesController.text = widget.address!.details;
      // Ideally we'd have more fields in AddressModel to map correctly. 
      // For now, we'll just set notes as a placeholder.
    }
  }

  @override
  void dispose() {
    companyController.dispose();
    buildingController.dispose();
    officeController.dispose();
    streetController.dispose();
    apartmentController.dispose();
    floorController.dispose();
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
          padding: EdgeInsets.all(AppSizes.padding.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BottomSheetHandle(),
              SizedBox(height: AppSizes.spacingLarge),
              Text(
                widget.isEdit ? AppStrings.editAddress : AppStrings.addYourAddress,
                style: AppText.ibmPlexSansArabic16SemiBold,
              ),
              SizedBox(height: AppSizes.spacingLarge),
              Row(
                children: [
                  AddressTypeSelector(
                    title: AppStrings.addressWork,
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
                    title: AppStrings.addressHome,
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
                      streetController: streetController,
                      buildingController: buildingController,
                      apartmentController: apartmentController,
                      floorController: floorController,
                    ),
              SizedBox(height: AppSizes.spacingMedium),
              AddressTextField(
                hintText: AppStrings.additionalNotes,
                controller: notesController,
                maxLines: 1,
              ),
              SizedBox(height: AppSizes.spacingXLarge),
              CustomButtom(
                text: widget.isEdit ? AppStrings.save : AppStrings.saveAddress,
                startColor: AppColors.greenPrimary,
                endColor: AppColors.greenPrimary,
                textStyle: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
