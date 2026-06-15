import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';

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
          SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.profileName,
                style: AppText.semiBoldText(
                  color: AppColors.headingText,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                AppStrings.phoneNumber,
                textDirection: TextDirection.ltr,
                style: AppText.regularText(
                  color: AppColors.secondaryText,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(width: 20),

          const Spacer(),
        ],
      ),
    );
  }
}
