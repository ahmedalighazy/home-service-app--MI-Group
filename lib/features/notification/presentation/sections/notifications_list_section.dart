import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:home_service_app/features/notification/presentation/widgets/notification_card.dart';
import 'package:home_service_app/features/notification/presentation/widgets/notification_group_header.dart';

class NotificationsListSection extends StatelessWidget {
  const NotificationsListSection({super.key, required this.notifications});

  final List<NotificationEntity> notifications;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<NotificationEntity>> groupedNotifications = {};

    for (final notification in notifications) {
      final groupKey = notification.group ?? 'other';
      groupedNotifications.putIfAbsent(groupKey, () => []);

      groupedNotifications[groupKey]!.add(notification);
    }

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding,
      ),
      children: groupedNotifications.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationGroupHeader(title: entry.key),

            SizedBox(height: AppSizes.spacingMedium),

            ...entry.value.asMap().entries.map((entryItem) {
              final notification = entryItem.value;

              return Padding(
                padding: EdgeInsets.only(bottom: AppSizes.spacingMedium),
                child: NotificationCard(
                  title: notification.title,
                  description: notification.description ?? '',
                  time: notification.time ?? '',
                  iconPath: notification.iconPath ?? '',
                  isRead: notification.isRead,
                  onTap: () {
                    context.read<NotificationCubit>().markAsRead(notification);
                  },
                ),
              );
            }),

            SizedBox(height: AppSizes.spacingLarge),
          ],
        );
      }).toList(),
    );
  }
}
