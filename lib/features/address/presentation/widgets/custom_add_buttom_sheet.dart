import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/address/presentation/bottom_sheets/add_address_bottom_sheet.dart';

class CustomAddButtomSheet extends StatelessWidget {
  const CustomAddButtomSheet({super.key, th, this.isProfileScreen = false});
  final bool? isProfileScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isProfileScreen!) {
          context.pop();
        }

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return const AddAddressBottomSheet();
          },
        );
      },
      borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSizes.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(color: AppColors.borderInputs),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppColors.greenPrimary),

            SizedBox(width: AppSizes.spacingSmall),

            Text(
              context.l10n.addNewAddress,
              style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                color: AppColors.greenPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
