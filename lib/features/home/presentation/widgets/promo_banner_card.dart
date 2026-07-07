import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/home/domain/entities/banner_entity.dart';

class PromoBannerCard extends StatelessWidget {
  const PromoBannerCard({super.key, required this.banner});

  final BannerEntity banner;

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
            Positioned.fill(
              child: Image.network(
                banner.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.only(
                top: AppSizes.paddingLarge,
                start: AppSizes.padding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.listingTitle,
                    textAlign: TextAlign.right,
                    style: AppText.ibmFieldLabel14(color: AppColors.secondary),
                  ),

                  SizedBox(height: AppSizes.spacingMin),

                  Text(
                    banner.listingTitle,
                    textAlign: TextAlign.right,
                    style: AppText.ibmPlexSansArabic12SemiBold,
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// Old Price
// ===================================================================

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

// ===================================================================
// Promo Code Badge
// ===================================================================

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
            padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
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
              ),
            ),
            child: Text(
              'CODE',
              style: AppText.ibmCaption11(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
