import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class HomeSpecialOfferSection extends StatelessWidget {
  const HomeSpecialOfferSection({
    super.key,
    required this.specialOfferTitle,
    required this.serviceAvailable24h,
  });
  final String specialOfferTitle;
  final String serviceAvailable24h;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bannerCardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .08),
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
              top: AppSizes.spacingXLarge,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddinMinHeight,
                ),
                decoration: BoxDecoration(
                  color: AppColors.greenPrimary,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(AppSizes.radiusMedium),
                  ),
                ),
                child: Text(
                  specialOfferTitle,
                  style: AppText.ibmFieldLabel14(color: AppColors.white),
                ),
              ),
            ),
            PositionedDirectional(
              bottom: AppSizes.spacingMedium,
              start: AppSizes.spacingMedium,
              child: Text(
                serviceAvailable24h,
                style: AppText.ibmCaption11(color: AppColors.white),
              ),
            ),
            //
            PositionedDirectional(
              end: 0,
              bottom: 0,
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.greenPrimary, AppColors.dark],
                    ),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(AppSizes.radiusLarge),
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(AppSizes.radiusLarge),
                    ).resolve(Directionality.of(context)),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingLarge,
                        vertical: AppSizes.paddingSmallHeight,
                      ),
                      child: Text(
                        context.l10n.bookNow,
                        style: AppText.ibmFieldLabel14(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
