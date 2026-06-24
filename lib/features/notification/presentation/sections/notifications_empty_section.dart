import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';

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
              context.tr(LocaleKeys.noNewNotifications),
              style: AppText.ibmPlexSansArabic16SemiBold,
            ),

            SizedBox(height: AppSizes.spacingLarge),
            CustomButtom(
              text: context.tr(LocaleKeys.browseServices),
              startColor: AppColors.greenPrimary,
              endColor: AppColors.dark,
              textStyle: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                color: AppColors.white,
              ),
              onTap: () => context.go(AppRouter.home),
            ),
          ],
        ),
      ),
    );
  }
}
