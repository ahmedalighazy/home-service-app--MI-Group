import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/notification/data/dummy/notification_dummy_data.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
    : super(
        NotificationState(notifications: NotificationDummyData.notifications),
      );

  void markAsRead(NotificationEntity notification) {
    final updatedNotifications = state.notifications
        .map(
          (item) => item == notification ? item.copyWith(isRead: true) : item,
        )
        .toList();

    emit(state.copyWith(notifications: updatedNotifications));
  }
}
