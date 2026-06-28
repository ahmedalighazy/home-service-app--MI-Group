import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String? badge;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        width: AppSizes.cardWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: AppSizes.paddinMinHeight,
              ),
              child: Text(title, style: AppText.ibmFieldLabel12()),
            ),

            // Discount Badge
            if (badge != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSmall,
                  vertical: AppSizes.paddinMinHeight,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
                child: Text(
                  badge!,
                  style: AppText.ibmPlexSansArabic12SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),

            SizedBox(height: AppSizes.spacingMin),

            // Image Section
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSizes.radius),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: AppSizes.cardImageHeight,
                    fit: BoxFit.cover,
                  ),
                ),

                // Arrow Button
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: Container(
                    width: AppSizes.arrowIconHeight,
                    height: AppSizes.arrowIconWidth,
                    decoration: BoxDecoration(
                      color: AppColors.greenPrimary,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(AppSizes.radiusLarge),
                        bottomEnd: Radius.circular(AppSizes.radius),
                      ),
                    ),
                    child: SvgPicture.asset(
                      IconsPath.arrowIcon,
                      fit: BoxFit.none,
                      width: AppSizes.iconSizeSmall,
                      height: AppSizes.iconSizeSmall,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Title Section
          ],
        ),
      ),
    );
  }
}
