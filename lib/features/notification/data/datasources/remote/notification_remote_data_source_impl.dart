import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_service.dart';
import '../../models/notification_model.dart';
import 'notification_remote_data_source.dart';

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiService apiService;

  NotificationRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<NotificationModel>> getNotifications() {
    return apiService.getNotifications();
  }

  @override
  Future<void> markAsRead(String id) {
    return apiService.markNotificationAsRead(id);
  }
}
