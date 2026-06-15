import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class SectionHeader extends StatelessWidget {
  SectionHeader({super.key, required this.title, this.onViewAll});

  final String title;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppText.ibmFieldLabel14(color: AppColors.primaryText),
        ),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            AppStrings.viewAll,
            style: AppText.ibmLink13(color: AppColors.secondaryGrey),
          ),
        ),
      ],
    );
  }
}
