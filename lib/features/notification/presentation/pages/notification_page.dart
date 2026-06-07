import 'package:flutter/material.dart';
import 'package:home_service_app/features/notification/data/dummy/notification_dummy_data.dart';
import 'package:home_service_app/features/notification/presentation/sections/notifications_empty_section.dart';
import 'package:home_service_app/features/notification/presentation/sections/notifications_list_section.dart';
import 'package:home_service_app/features/notification/presentation/widgets/notification_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationDummyData.notifications;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const NotificationAppBar(),

            Expanded(
              child: notifications.isEmpty
                  ? const NotificationsEmptySection()
                  : NotificationsListSection(notifications: notifications),
            ),
          ],
        ),
      ),
    );
  }
}
