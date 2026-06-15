import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../datasources/notification_local_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NotificationLocalDataSource localDataSource;

  NotificationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    try {
      final notificationModels = await remoteDataSource.getNotifications();
      await localDataSource.cacheNotifications(notificationModels);
      return notificationModels.map((model) => _toNotificationEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedNotifications();
      if (cached != null) {
        return cached.map((model) => _toNotificationEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> markAllAsRead() async {
    await remoteDataSource.markAllAsRead();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await remoteDataSource.deleteNotification(notificationId);
  }

  NotificationEntity _toNotificationEntity(NotificationModel model) {
    return NotificationEntity(
      id: model.title,
      title: model.title,
      body: model.description,
      createdAt: DateTime.tryParse(model.time) ?? DateTime.now(),
      isRead: model.isRead,
    );
  }
}
