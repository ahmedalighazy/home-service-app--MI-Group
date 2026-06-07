import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/search/presentation/widgets/custom_button.dart';

class NotificationsEmptySection extends StatelessWidget {
  const NotificationsEmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.notificationIcon),

            SizedBox(height: AppSizes.spacingLarge),

            Text(
              AppStrings.noNewNotifications,
              style: AppText.ibmPlexSansArabic16SemiBold,
            ),

            SizedBox(height: AppSizes.spacingLarge),

            CustomButton(
              text: AppStrings.browseServices,
              textColor: AppColors.white,
              backGroundColor: const [AppColors.greenPrimary, AppColors.dark],
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
