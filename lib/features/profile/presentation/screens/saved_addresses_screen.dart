import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/domain/entities/address_entity.dart';
import 'package:home_service_app/features/profile/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/profile/presentation/screens/add_edit_address_screen.dart';
import 'package:home_service_app/features/profile/presentation/widgets/address_card_widget.dart';
import 'package:home_service_app/features/profile/presentation/widgets/delete_address_dialog.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().getAddresses();
  }

  void _onAddAddress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (_) => const AddEditAddressScreen(),
    );
  }

  void _onEditAddress(AddressEntity address) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (_) => AddEditAddressScreen(address: address),
    );
  }

  void _onDeleteAddress(AddressEntity address) {
    showDialog(
      context: context,
      builder: (_) => DeleteAddressDialog(
        isDefault: address.isDefault,
        onDelete: () {
          context.read<AddressCubit>().deleteAddress(address.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr(LocaleKeys.profileSavedAddressesHeader),
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AddressError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      style: AppText.ibmDescription14(
                        color: AppColors.textLightGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(16),
                    IconButton(
                      onPressed: () =>
                          context.read<AddressCubit>().getAddresses(),
                      icon: const Icon(Icons.refresh,
                          color: AppColors.primary, size: 32),
                    ),
                  ],
                ),
              ),
            );
          }

          final addresses = state is AddressesLoaded
              ? state.addresses
              : <AddressEntity>[];

          if (addresses.isEmpty) {
            return EmptyStateWidget(
              iconPath: IconsPath.union,
              title: context.tr(LocaleKeys.profileNoAddressesYet),
              subtitle:
                  context.tr(LocaleKeys.profileAddFavoriteAddressesDesc),
              buttonLabel: context.tr(LocaleKeys.profileAddAddressBtn),
              onButtonPressed: _onAddAddress,
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(24),
                Text(
                  context.tr(LocaleKeys.profileMySavedAddresses),
                  style: AppText.ibmHeading16(color: AppColors.black),
                ),
                verticalSpace(16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: addresses.length,
                  separatorBuilder: (_, _) => verticalSpace(12),
                  itemBuilder: (context, index) {
                    final address = addresses[index];
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
          );
        },
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
          border: Border.all(
            color: AppColors.borderInputs,
            style: BorderStyle.solid,
          ),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppColors.primary),
            horizontalSpace(8),
            Text(
              context.tr(LocaleKeys.profileAddAddressBtn),
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
