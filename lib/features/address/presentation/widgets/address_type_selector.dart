import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class AddressTypeSelector extends StatelessWidget {
  const AddressTypeSelector({
    super.key,
    required this.title,
    required this.isSelected,
    required this.iconsPath,
    this.onTap,
  });

  final String title;
  final String iconsPath;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(

        onTap: onTap,
        child: Container(
          width: AppSizes.cardImageHeight,
          height: AppSizes.sectionOffset,

          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenPrimary : AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
            border: Border.all(
              color: isSelected
                  ? AppColors.greenPrimary
                  : AppColors.borderInputs,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              SvgPicture.asset(
                iconsPath,
                width: AppSizes.iconSize,
                height: AppSizes.iconSize,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.white : AppColors.primaryText,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                title,
                style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: isSelected ? AppColors.white : AppColors.primaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
