import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.89,
      height: height(context) / 8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: const [
          BoxShadow(
            color: AppColors.black100,
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          CircleAvatar(
            backgroundColor: AppColors.white,
            radius: 35,
            child: Image.asset(AppAssets.cleaningGuy, fit: BoxFit.cover),
          ),
          horizontalSpace(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(LocaleKeys.profileName),
                style: AppText.semiBoldText(
                  color: AppColors.headingText,
                  fontSize: 12,
                ),
              ),
              verticalSpace(5),
              Text(
                context.tr(LocaleKeys.profilePhoneNumber),
                textDirection: TextDirection.ltr,
                style: AppText.regularText(
                  color: AppColors.secondaryText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          horizontalSpace(20),
          const Spacer(),
        ],
      ),
    );
  }
}
