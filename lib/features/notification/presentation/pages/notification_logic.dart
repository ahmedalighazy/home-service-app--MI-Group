import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';

mixin NotificationLogic<T extends StatefulWidget> on State<T> {
  void markNotificationAsRead(
      BuildContext context, NotificationEntity notification) {
    context.read<NotificationCubit>().markAsRead(notification);
  }

  void markAllAsRead(BuildContext context) {
    final state = context.read<NotificationCubit>().state;
    for (final n in state.notifications) {
      if (!n.isRead) {
        context.read<NotificationCubit>().markAsRead(n);
      }
    }
  }
}
