import '../models/notification_model.dart';

abstract class NotificationLocalDataSource {
  Future<void> cacheNotifications(List<NotificationModel> notifications);
  Future<List<NotificationModel>?> getCachedNotifications();
  Future<void> clearCache();
}
