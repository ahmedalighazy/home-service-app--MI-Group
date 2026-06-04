import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class HomeSpecialOfferSection extends StatelessWidget {
  const HomeSpecialOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding.w),
      child: Container(
        height: AppSizes.bannerCardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: .08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radius.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.specialOfferBanner,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: .30),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              PositionedDirectional(
                top: AppSizes.spacingXLarge.h,
                start: AppSizes.spacingSmall.w,
                // end: AppSizes.spacingLarge.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding.w,
                    vertical: AppSizes.paddingSmall.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greenPrimary,
                    borderRadius: BorderRadius.circular(
                      AppSizes.radiusMedium.r,
                    ),
                  ),
                  child: Text(
                    'عروض مخصصة للشركات والمؤسسات',
                    style: AppText.ibmFieldLabel14(color: AppColors.white),
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: AppSizes.spacingMedium.h,
                start: AppSizes.spacingMedium.w,
                child: Text(
                  'خدمة سريعة خلال 24 ساعة',
                  style: AppText.ibmCaption11(color: AppColors.white),
                ),
              ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenPrimary,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(AppSizes.radiusLarge.r),
                      ),
                    ),
                  ),
                  child: Text(
                    AppStrings.bookNow,
                    style: AppText.ibmFieldLabel14(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
