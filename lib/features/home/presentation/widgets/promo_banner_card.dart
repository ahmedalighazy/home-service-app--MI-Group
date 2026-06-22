import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
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
    return Container(
      width: double.infinity,
      height: AppSizes.bannerCardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius),
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),

            Padding(
              padding: EdgeInsetsDirectional.only(
                top: AppSizes.paddingLarge,
                start: AppSizes.padding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: AppText.ibmFieldLabel14(color: AppColors.secondary),
                  ),

                  SizedBox(height: AppSizes.spacingMin),

                  Text(
                    subTitle,
                    textAlign: TextAlign.right,
                    style: AppText.ibmPlexSansArabic12SemiBold,
                  ),

                  SizedBox(height: AppSizes.spacingSmall),

                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppSizes.paddingXXLarge,
                    ),
                    child: OldPrice(price: price),
                  ),

                  SizedBox(height: AppSizes.spacingMin),

                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppSizes.padding,
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

        Positioned(
          child: Transform.rotate(
            angle: -0.35,
            child: Container(
              width: 33,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
              ),
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(AppSizes.radius),
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingSmall,

            ),
            child: Text(
              promoCode,
              style: AppText.ibmCaption11(color: AppColors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingSmall,
              vertical: AppSizes.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: AppColors.greenPrimary,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(AppSizes.radius),
                topEnd: Radius.zero,
              ),
            ),
            child: Text(
              context.l10n.code,
              style: AppText.ibmCaption11(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
