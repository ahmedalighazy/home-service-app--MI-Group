import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/notification/domain/usecases/mark_notification_as_read_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import 'notification_state.dart';

@lazySingleton
class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;

  NotificationCubit(
    this.getNotificationsUseCase,
    this.markNotificationAsReadUseCase,
  ) : super(const NotificationState());

  Future<void> getNotifications() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getNotificationsUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (notifications) {
        emit(state.copyWith(isLoading: false, notifications: notifications));
      },
    );
  }

  Future<void> markAsRead(NotificationEntity notification) async {
    final result = await markNotificationAsReadUseCase(notification.id);

    result.fold(
      (failure) {
        // ممكن تعرض Snackbar أو تسيبها فاضية
      },
      (_) {
        final updatedNotifications = state.notifications.map((item) {
          if (item.id == notification.id) {
            return item.copyWith(isRead: true);
          }
          return item;
        }).toList();

        emit(state.copyWith(notifications: updatedNotifications));
      },
    );
  }
}
