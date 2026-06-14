import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:home_service_app/features/notification/data/dummy/notification_dummy_data.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_state.dart';

@lazySingleton
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(_initialState());

  static NotificationState _initialState() {
    return NotificationState(
      notifications: NotificationDummyData.notifications,
    );
  }

  void markAsRead(NotificationEntity notification) {
    final updatedNotifications = state.notifications
        .map(
          (item) => item == notification ? item.copyWith(isRead: true) : item,
        )
        .toList();

    emit(state.copyWith(notifications: updatedNotifications));
  }
}
