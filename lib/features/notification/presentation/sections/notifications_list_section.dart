import 'package:easy_localization/easy_localization.dart' as context;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:home_service_app/features/notification/presentation/widgets/notification_card.dart';
import 'package:home_service_app/features/notification/presentation/widgets/notification_group_header.dart';

class NotificationsListSection extends StatelessWidget {
  const NotificationsListSection({super.key, required this.notifications});

  final List<NotificationEntity> notifications;

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = <String, List<NotificationEntity>>{};

    for (final notification in notifications) {
      final group = _getGroup(notification.createdAt);

      groupedNotifications.putIfAbsent(group, () => []);
      groupedNotifications[group]!.add(notification);
    }

    return ListView(
      padding: EdgeInsets.all(AppSizes.padding),
      children: groupedNotifications.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationGroupHeader(title: entry.key),

            ...entry.value.map(
              (notification) => Padding(
                padding: EdgeInsets.only(bottom: AppSizes.paddingSmall),
                child: NotificationCard(
                  notification: notification,
                  onTap: () {
                    context.read<NotificationCubit>().markAsRead(notification);
                  },
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  String _getGroup(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final notificationDate = DateTime(date.year, date.month, date.day);

    final difference = today.difference(notificationDate).inDays;

    if (difference == 0) {
      return context.tr(LocaleKeys.today);
    }

    if (difference == 1) {
      return context.tr(LocaleKeys.yesterday);
    }

    return context.tr(LocaleKeys.earlier);
  }
}
