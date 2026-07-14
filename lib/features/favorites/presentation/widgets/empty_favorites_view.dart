import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            IconsPath.illustration,
            width: 200.w,
            height: 177.h,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.favorite_border,
              size: 100.r,
              color: AppColors.borderGrey,
            ),
          ),
          verticalSpace(16),
          Text(
            context.tr(LocaleKeys.profileNoFavoritesYetTitle),
            textAlign: TextAlign.center,
            style: AppText.semiBoldIbm(
              color: AppColors.primaryText,
              fontSize: 16,
            ),
          ),
          verticalSpace(8),
          Text(
            context.tr(LocaleKeys.profileSaveServicesToAccessLater),
            textAlign: TextAlign.center,
            style: AppText.ibmDescription14(color: AppColors.secondaryText),
          ),
          verticalSpace(24),
          CustomButtom(
            text: context.tr(LocaleKeys.profileBrowseServicesBtn),
            onTap: () {
              Navigator.of(context).pop();
            },
            startColor: AppColors.greenPrimary,
            endColor: AppColors.dark,
            textStyle: AppText.ibmButton16(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
