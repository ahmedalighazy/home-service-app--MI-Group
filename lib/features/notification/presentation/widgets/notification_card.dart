import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.iconPath,
    this.isRead = false,
    this.onTap,
  });

  final String title;
  final String description;
  final String time;
  final String iconPath;
  final bool isRead;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: isRead
              ? AppColors.white
              : AppColors.greenPrimary.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              width: AppSizes.iconSize,
              height: AppSizes.iconSize,
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: AppText.ibmPlexSansArabic16SemiBold,
                  ),

                  SizedBox(height: AppSizes.spacingMin),

                  Text(
                    description,
                    textAlign: TextAlign.right,
                    style: AppText.ibmDescription14(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Text(
              time,
              style: AppText.ibmCaption11(color: AppColors.placeholder),
            ),
          ],
        ),
      ),
    );
  }
}
