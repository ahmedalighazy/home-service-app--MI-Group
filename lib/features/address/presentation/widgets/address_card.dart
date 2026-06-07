import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.title,
    required this.address,
    required this.iconPath,
    this.isSelected = false,
    this.onTap,
  });

  final String title;
  final String address;
  final String iconPath;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.radius),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.greenPrimary.withValues(alpha: .08)
              : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius),
          border: Border.all(
            color: isSelected ? AppColors.greenPrimary : AppColors.borderInputs,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.iconSizeXLarge,
              height: AppSizes.iconSizeXLarge,
              decoration: BoxDecoration(
                color: AppColors.greenPrimary,
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: AppSizes.iconSize,
                  height: AppSizes.iconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.ibmPlexSansArabic16SemiBold),

                  SizedBox(height: AppSizes.spacingMin),

                  Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: AppText.ibmDescription14(
                      color: AppColors.placeholder,
                    ),
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
