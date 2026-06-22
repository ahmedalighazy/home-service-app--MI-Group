import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/icons_path.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/l10n/locale_keys.dart';
import '../../../../core/utils/l10n/localization_extension.dart';
import '../../../../core/widgets/custom_buttom.dart';

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
