import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class SearchCategoryCard extends StatelessWidget {
  const SearchCategoryCard({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.borderInputs,
          borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        ),
        child: Text(
          title,
          style: AppText.ibmDescription14(color: AppColors.primaryText),
        ),
      ),
    );
  }
}
