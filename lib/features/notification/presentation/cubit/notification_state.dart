import 'package:equatable/equatable.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';

class NotificationState extends Equatable {
  final List<NotificationEntity> notifications;

  const NotificationState({this.notifications = const []});

  NotificationState copyWith({List<NotificationEntity>? notifications}) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [notifications];
}
