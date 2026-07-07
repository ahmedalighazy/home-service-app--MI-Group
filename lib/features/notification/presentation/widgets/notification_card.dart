import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification, this.onTap});

  final NotificationEntity notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.white
              : AppColors.greenPrimary.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.imageUrl != null &&
                notification.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                child: Image.network(
                  notification.imageUrl!,
                  width: AppSizes.iconSize,
                  height: AppSizes.iconSize,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(Icons.notifications),
                ),
              )
            else
              const Icon(Icons.notifications, color: AppColors.greenPrimary),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppText.ibmPlexSansArabic16SemiBold,
                  ),

                  SizedBox(height: AppSizes.spacingMin),

                  Text(
                    notification.body,
                    style: AppText.ibmDescription14(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Text(
              DateFormat('hh:mm a').format(notification.createdAt),
              style: AppText.ibmCaption11(color: AppColors.placeholder),
            ),
          ],
        ),
      ),
    );
  }
}
