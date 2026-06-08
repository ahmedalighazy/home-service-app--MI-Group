import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/address/presentation/bottom_sheets/add_address_bottom_sheet.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_state.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_card.dart';
import 'package:home_service_app/features/address/presentation/widgets/bottom_sheet_handle.dart';

class SavedAddressesBottomSheet extends StatelessWidget {
  const SavedAddressesBottomSheet({super.key});

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
        child: Padding(
          padding: EdgeInsets.all(AppSizes.padding),
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetHandle(),

                  SizedBox(height: AppSizes.spacingLarge),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppStrings.chooseYourAddress,
                      style: AppText.ibmPlexSansArabic16SemiBold,
                    ),
                  ),

                  SizedBox(height: AppSizes.spacingLarge),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) {
                          return const AddAddressBottomSheet();
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(AppSizes.radius),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: AppSizes.padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.radius),
                        border: Border.all(color: AppColors.borderInputs),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, color: AppColors.greenPrimary),

                          SizedBox(width: AppSizes.spacingSmall),

                          Text(
                            AppStrings.addYourAddress,
                            style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                              color: AppColors.greenPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: AppSizes.spacingLarge),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.addresses.length,
                    separatorBuilder: (_, _) =>
                        SizedBox(height: AppSizes.spacingMedium),
                    itemBuilder: (context, index) {
                      final address = state.addresses[index];

                      return GestureDetector(
                        onTap: () {
                          context.read<AddressCubit>().selectAddress(index);
                        },
                        child: AddressCard(
                          title: address.title,
                          address: address.address,
                          iconPath: address.iconPath,
                          isSelected: address.isSelected,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppSizes.spacingMedium),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.editAddressHint,
                      style: AppText.ibmCaption11(
                        color: AppColors.greenPrimary,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
