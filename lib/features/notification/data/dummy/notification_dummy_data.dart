import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';

class NotificationDummyData {
  NotificationDummyData._();

  static final notifications = [
    NotificationEntity(
      id: '1',
      title: 'تم تأكيد الخدمة',
      body: 'تم تأكيد طلبك وسيتم التواصل معك قريباً',
      createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
      time: 'منذ دقيقة',
      group: 'اليوم',
      iconPath: IconsPath.manualCleanerIcon,
    ),

    NotificationEntity(
      id: '2',
      title: 'خصم جديد',
      body: 'خصم 20% على خدمات التنظيف',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      time: 'منذ ساعة',
      group: 'اليوم',
      iconPath: IconsPath.manualCleanerIcon,
    ),

    NotificationEntity(
      id: '3',
      title: 'تم قبول الطلب',
      body: 'تم قبول طلبك وسيتم البدء في التنفيذ',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      time: 'منذ يوم',
      group: 'الأمس',
      iconPath: IconsPath.cleanerIcon,
      isRead: true,
    ),
  ];
}
