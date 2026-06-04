import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';
import 'package:home_service_app/features/profile/presentation/widgets/address_card_widget.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  // Mock data for demonstration
  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      label: AppStrings.homeAddress,
      details: 'شارع 123، فيلا 5، الدوحة، قطر',
      isDefault: true,
      iconPath: IconsPath.house,
    ),
    AddressModel(
      id: '2',
      label: AppStrings.workAddress,
      details: 'برج السلام، الدور 15، شارع الكورنيش، الدوحة',
      isDefault: false,
      iconPath: IconsPath.work,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: CustomAppBar(
        title: AppStrings.savedAddressesHeader,
        onBack: () => Navigator.pop(context),
      ),
      body: _addresses.isEmpty
          ? EmptyStateWidget(
              iconPath: IconsPath.emptyAddresses,
              title: AppStrings.noAddressesYet,
              subtitle: AppStrings.addFavoriteAddressesDesc,
              buttonLabel: AppStrings.addAddressBtn,
              onButtonPressed: () {
                // Navigate to add address
              },
            )
          : ListView.separated(
              padding: EdgeInsets.all(AppSizes.paddingM.r),
              itemCount: _addresses.length,
              separatorBuilder: (context, index) => verticalSpace(12),
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return AddressCardWidget(
                  address: address,
                  onEdit: () {
                    // Logic to edit address
                  },
                  onDelete: () {
                    // Logic to delete address
                  },
                );
              },
            ),
      bottomNavigationBar: _addresses.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(AppSizes.paddingM.r),
              child: CustomButtom(
                text: AppStrings.addAddressBtn,
                onTap: () {
                  // Navigate to add address
                },
                startColor: AppColors.greenPrimary,
                endColor: AppColors.dark,
                textStyle: AppText.ibmButton16(color: AppColors.white),
              ),
            )
          : null,
    );
  }
}
