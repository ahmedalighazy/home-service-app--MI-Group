import 'package:equatable/equatable.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final List<NotificationEntity> notifications;
  final String? errorMessage;

  const NotificationState({
    this.isLoading = false,
    this.notifications = const [],
    this.errorMessage,
  });

  NotificationState copyWith({
    bool? isLoading,
    List<NotificationEntity>? notifications,
    String? errorMessage,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, notifications, errorMessage];
}
