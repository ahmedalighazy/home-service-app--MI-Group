import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_state.dart';
import 'package:home_service_app/features/address/presentation/widgets/address_card.dart';
import 'package:home_service_app/features/address/presentation/widgets/bottom_sheet_handle.dart';
import 'package:home_service_app/features/address/presentation/widgets/custom_add_buttom_sheet.dart';

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
                      context.tr(LocaleKeys.chooseYourAddress),
                      style: AppText.ibmPlexSansArabic16SemiBold,
                    ),
                  ),

                  SizedBox(height: AppSizes.spacingLarge),

                  CustomAddButtomSheet(),

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

                          context.pop();
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
                    onPressed: () => context.push(AppRouter.savedAddresses),
                    child: Text(
                      context.tr(LocaleKeys.editAddressHint),
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
