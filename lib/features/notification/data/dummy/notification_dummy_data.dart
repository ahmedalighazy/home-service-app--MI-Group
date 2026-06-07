import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/features/notification/domain/entities/notification_entity.dart';

class NotificationDummyData {
  const NotificationDummyData._();

  static const notifications = [
    NotificationEntity(
      title: 'تم تأكيد الخدمة',
      description: 'تم تأكيد طلبك وسيتم التواصل معك قريباً',
      time: 'منذ دقيقة',
      group: 'اليوم',
      iconPath: IconsPath.manualCleanerIcon,
    ),

    NotificationEntity(
      title: 'خصم جديد',
      description: 'خصم 20% على خدمات التنظيف',
      time: 'منذ ساعة',
      group: 'اليوم',
      iconPath: IconsPath.manualCleanerIcon,
    ),

    NotificationEntity(
      title: 'تم قبول الطلب',
      description: 'تم قبول طلبك وسيتم البدء في التنفيذ',
      time: 'منذ يوم',
      group: 'الأمس',
      iconPath: IconsPath.cleanerIcon,
      isRead: true,
    ),
  ];
}
