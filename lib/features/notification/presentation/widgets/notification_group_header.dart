import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class NotificationGroupHeader extends StatelessWidget {
  const NotificationGroupHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
