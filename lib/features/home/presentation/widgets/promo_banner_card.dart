import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/app_strings.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class PromoBannerCard extends StatelessWidget {
  const PromoBannerCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.offerPrice,
    required this.promoCode,
    required this.imagePath,
  });

  final String title;
  final String subTitle;
  final String price;
  final String offerPrice;
  final String promoCode;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding.w),
      child: Container(
        width: double.infinity,
        height: AppSizes.bannerCardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: .05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radius.r),
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),

              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: AppSizes.sectionOffset.h,
                  start: AppSizes.padding.w,
                ), // EdgeInsets.only(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: AppText.ibmFieldLabel14(
                        color: AppColors.secondary,
                      ),
                    ),

                    SizedBox(height: AppSizes.spacingMin.h),

                    Text(
                      subTitle,
                      textAlign: TextAlign.right,
                      style: AppText.ibmPlexSansArabic12SemiBold,
                    ),

                    SizedBox(height: AppSizes.spacingSmall.h),

                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: AppSizes.sectionOffset.w,
                      ),
                      child: OldPrice(price: price),
                    ),

                    SizedBox(height: AppSizes.spacingMin.h),

                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: AppSizes.paddingMedium.w,
                      ),
                      child: Text(
                        offerPrice,
                        style: AppText.ibmPlexSansArabic12SemiBold.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: PromoCodeBadge(promoCode: promoCode),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OldPrice extends StatelessWidget {
  const OldPrice({super.key, required this.price});

  final String price;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          price,
          style: AppText.ibmPlexSansArabic12SemiBold.copyWith(fontSize: 14.sp),
        ),

        Transform.rotate(
          angle: -0.35,
          child: Container(
            width: 33.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: AppColors.errorRed,
              borderRadius: BorderRadius.circular(AppSizes.radiusXL.r),
            ),
          ),
        ),
      ],
    );
  }
}

class PromoCodeBadge extends StatelessWidget {
  const PromoCodeBadge({super.key, required this.promoCode});

  final String promoCode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusSmall.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(AppSizes.radiusLarge.r),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall.w,
                vertical: AppSizes.paddingSmall.h,
              ),
              child: Text(
                promoCode,
                style: AppText.ibmCaption11(color: AppColors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall.w,
                vertical: AppSizes.paddingSmall.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.greenPrimary,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(AppSizes.radiusLarge.r),
                ),
              ),
              child: Text(
                AppStrings.code,
                style: AppText.ibmCaption11(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
