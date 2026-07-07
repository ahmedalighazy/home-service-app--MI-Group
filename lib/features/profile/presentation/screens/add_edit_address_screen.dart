import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_text_field.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_type_selector.dart';
import 'package:home_service_app/features/address/presentation/widgets/bottom_sheet_handle.dart';
import 'package:home_service_app/features/address/presentation/widgets/home_address_fields.dart';
import 'package:home_service_app/features/address/presentation/widgets/work_address_fields.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../../domain/entities/address_entity.dart';
import '../cubit/address_cubit.dart';

class AddEditAddressScreen extends StatefulWidget {
  final AddressEntity? address;

  const AddEditAddressScreen({super.key, this.address});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  bool get isEditing => widget.address != null;

  bool isWorkSelected = true;

  late final TextEditingController _companyController;
  late final TextEditingController _buildingController;
  late final TextEditingController _officeController;
  late final TextEditingController _apartmentController;
  late final TextEditingController _floorController;
  late final TextEditingController _streetController;
  late final TextEditingController _notesController;
  late final TextEditingController _labelController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _companyController = TextEditingController();
    _buildingController = TextEditingController();
    _officeController = TextEditingController();
    _apartmentController = TextEditingController();
    _floorController = TextEditingController();
    _streetController = TextEditingController();
    _notesController = TextEditingController();
    _labelController = TextEditingController();
    _descriptionController = TextEditingController();

    if (isEditing) {
      final a = widget.address!;
      isWorkSelected = a.type == 'OFFICE';
      _streetController.text = a.streetName ?? '';
      _buildingController.text = a.buildingNumber ?? '';
      _apartmentController.text = a.apartmentNumber ?? '';
      _floorController.text = a.floorNumber ?? '';
      _notesController.text = a.notes ?? '';
      _labelController.text = a.label ?? '';
      _descriptionController.text = a.description ?? '';
      _companyController.text = a.label ?? '';
    }
  }

  @override
  void dispose() {
    _companyController.dispose();
    _buildingController.dispose();
    _officeController.dispose();
    _apartmentController.dispose();
    _floorController.dispose();
    _streetController.dispose();
    _notesController.dispose();
    _labelController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    final cubit = context.read<AddressCubit>();
    final type = isWorkSelected ? 'OFFICE' : 'HOME';

    // Simple required fields validation
    if (isWorkSelected && _companyController.text.trim().isEmpty) return;
    if (!isWorkSelected && _streetController.text.trim().isEmpty) return;

    if (isEditing) {
      cubit.updateAddress(
        id: widget.address!.id,
        type: type,
        label: isWorkSelected
            ? _companyController.text.trim()
            : _labelController.text.trim(),
        streetName: _streetController.text.trim(),
        buildingNumber: _buildingController.text.trim(),
        apartmentNumber: _apartmentController.text.trim(),
        floorNumber: _floorController.text.trim(),
        notes: _notesController.text.trim(),
        description: _descriptionController.text.trim(),
      );
    } else {
      cubit.createAddress(
        longitude: 0.0,
        latitude: 0.0,
        type: type,
        label: isWorkSelected
            ? _companyController.text.trim()
            : _labelController.text.trim(),
        streetName: _streetController.text.trim(),
        buildingNumber: _buildingController.text.trim(),
        apartmentNumber: _apartmentController.text.trim(),
        floorNumber: _floorController.text.trim(),
        notes: _notesController.text.trim(),
        description: _descriptionController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, AddressState>(
      listenWhen: (previous, current) =>
          current is CreateAddressSuccess ||
          current is UpdateAddressSuccess ||
          current is CreateAddressError ||
          current is UpdateAddressError,
      listener: (context, state) {
        if (state is CreateAddressSuccess || state is UpdateAddressSuccess) {
          context.pop();
        } else if (state is CreateAddressError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UpdateAddressError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          final isSaving =
              state is CreateAddressLoading || state is UpdateAddressLoading;

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
                      isEditing
                          ? context.tr(LocaleKeys.profileEditAction)
                          : context.tr(LocaleKeys.addNewAddress),
                      style: AppText.ibmPlexSansArabic16SemiBold,
                    ),
                    SizedBox(height: AppSizes.spacingLarge),
                    Row(
                      children: [
                        AddressTypeSelector(
                          title: context.tr(LocaleKeys.addressWork),
                          iconsPath: IconsPath.institutionsIcon,
                          isSelected: isWorkSelected,
                          onTap: () =>
                              setState(() => isWorkSelected = true),
                        ),
                        SizedBox(width: AppSizes.spacingMedium),
                        AddressTypeSelector(
                          iconsPath: IconsPath.home,
                          title: context.tr(LocaleKeys.addressHome),
                          isSelected: !isWorkSelected,
                          onTap: () =>
                              setState(() => isWorkSelected = false),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.spacingLarge),
                    isWorkSelected
                        ? WorkAddressFields(
                            companyController: _companyController,
                            buildingController: _buildingController,
                            officeController: _officeController,
                          )
                        : HomeAddressFields(
                            streetController: _streetController,
                            buildingController: _buildingController,
                            apartmentController: _apartmentController,
                            floorController: _floorController,
                          ),
                    SizedBox(height: AppSizes.spacingMedium),
                    AddressTextField(
                      hintText: context.tr(LocaleKeys.additionalNotes),
                      controller: _notesController,
                      maxLines: 1,
                    ),
                    SizedBox(height: AppSizes.spacingXLarge),
                    isSaving
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButtom(
                            text: context.tr(LocaleKeys.saveAddress),
                            startColor: AppColors.greenPrimary,
                            endColor: AppColors.greenPrimary,
                            textStyle:
                                AppText.ibmPlexSansArabic16SemiBold.copyWith(
                              color: AppColors.white,
                            ),
                            onTap: _onSave,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
