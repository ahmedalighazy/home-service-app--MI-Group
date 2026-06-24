import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparentColor,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          //horizontal: AppSizes.padding,
          vertical: AppSizes.paddingSmall,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: AppSizes.iconSize,
              color: AppColors.placeholder,
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: Text(
                title,
                style: AppText.ibmDescription14(color: AppColors.primaryText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
