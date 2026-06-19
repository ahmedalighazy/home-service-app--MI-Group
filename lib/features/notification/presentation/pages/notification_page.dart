import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_state.dart';
import 'package:home_service_app/features/notification/presentation/sections/notifications_empty_section.dart';
import 'package:home_service_app/features/notification/presentation/sections/notifications_list_section.dart';

import '../../../../core/utils/l10n/app_strings.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.notifications),
      body: SafeArea(
        child: Column(
          children: [
            // const NotificationAppBar(),
            Expanded(
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state.notifications.isEmpty) {
                    return const NotificationsEmptySection();
                  }

                  return NotificationsListSection(
                    notifications: state.notifications,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
