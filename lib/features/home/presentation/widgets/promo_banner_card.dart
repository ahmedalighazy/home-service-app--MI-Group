import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
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
        height: AppSizes.promoBannerCardHeight,
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

              Positioned.fill(
                child: Container(color: AppColors.white.withValues(alpha: .08)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.paddingLarge,
                  right: AppSizes.padding,
                  left: AppSizes.padding,
                  bottom: AppSizes.padding,
                ),
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
                      padding: const EdgeInsetsDirectional.only(
                        start: AppSizes.paddingLarge,
                      ),
                      child: OldPrice(price: price),
                    ),

                    SizedBox(height: AppSizes.spacingMin.h),

                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: AppSizes.paddingMedium,
                      ),
                      child: Text(
                        offerPrice,
                        textAlign: TextAlign.right,
                        style: AppText.ibmPlexSansArabic12SemiBold.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greenPrimary,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall.r,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              promoCode,
                              style: AppText.ibmCaption11(
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: AppSizes.spacingMin.w),
                            Text(
                              'code',
                              style: AppText.ibmCaption11(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
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
          style: AppText.ibmPlexSansArabic12SemiBold.copyWith(fontSize: 14),
        ),

        Positioned(
          child: Transform.rotate(
            angle: -0.35,
            child: Container(
              width: 33,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(AppSizes.radiusXL),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
