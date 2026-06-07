import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class ServiceCategoryCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  const ServiceCategoryCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSizes.categoryCardWidth,
        child: Column(
          children: [
            Container(
              width: AppSizes.categoryIconContainerSize,
              height: AppSizes.categoryIconContainerSizeHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.grayWhite,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: SvgPicture.asset(
                iconPath,
                width: AppSizes.iconSizeLarge,
                height: AppSizes.iconSizeLarge,
                colorFilter: const ColorFilter.mode(
                  AppColors.greenPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            SizedBox(height: AppSizes.spacingMin),

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppText.mediumIbm(
                color: AppColors.primaryText,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
