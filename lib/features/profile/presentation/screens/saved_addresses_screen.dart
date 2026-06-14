import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/address/presentation/bottom_sheets/add_address_bottom_sheet.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';
import 'package:home_service_app/features/profile/presentation/widgets/address_card_widget.dart';
import 'package:home_service_app/core/utils/helpers/show_dialog.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  // This will be replaced by BLoC state in the future
  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      label: AppStrings.addressHome,
      details: 'شارع اللؤلؤة، فيلا رقم 42، الدوحة، قطر',
      isDefault: true,
      iconPath: IconsPath.iconHome,
    ),
    AddressModel(
      id: '2',
      label: AppStrings.addressWork,
      details: 'برج المرقاب . الطابق الثامن',
      isDefault: false,
      iconPath: IconsPath.work,
    ),
  ];

  void _onAddAddress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (_) => const AddAddressBottomSheet(),
    );
  }

  void _onEditAddress(AddressModel address) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (_) => AddAddressBottomSheet(
        address: address,
        isEdit: true,
      ),
    );
  }

  void _onDeleteAddress(AddressModel address) {
    showCannotDeleteDialogred(
      context,
      AppStrings.deleteAddressTitle,
      AppStrings.deleteAddressConfirmation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.savedAddressesHeader),
      body: _addresses.isEmpty
          ? EmptyStateWidget(
              iconPath: IconsPath.union,
              title: AppStrings.noAddressesYet,
              subtitle: AppStrings.addFavoriteAddressesDesc,
              buttonLabel: AppStrings.addAddressBtn,
              onButtonPressed: _onAddAddress,
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(24),
                  Text(
                    AppStrings.mySavedAddresses,
                    style: AppText.ibmHeading16(color: AppColors.black),
                  ),
                  verticalSpace(16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _addresses.length,
                    separatorBuilder: (_, _) => verticalSpace(12),
                    itemBuilder: (context, index) {
                      final address = _addresses[index];
                      return AddressCardWidget(
                        address: address,
                        onEdit: () => _onEditAddress(address),
                        onDelete: () => _onDeleteAddress(address),
                      );
                    },
                  ),
                  verticalSpace(24),
                  _AddAddressButton(onTap: _onAddAddress),
                  verticalSpace(24),
                ],
              ),
            ),
    );
  }
}

class _AddAddressButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddAddressButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
          border: Border.all(color: AppColors.borderInputs, style: BorderStyle.solid),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppColors.primary),
            horizontalSpace(8),
            Text(
              AppStrings.addAddressBtn,
              style: AppText.semiBoldIbm(
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
