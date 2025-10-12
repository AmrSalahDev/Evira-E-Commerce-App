import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';

abstract class NotificationRepo {
  Future<List<NotificationEntity>> getNotifications();
  Future<void> updateNotification(int id, bool isSeen);
  Future<void> deleteNotification(int id);
  Future<int> getUnseenCount();
  Future<void> markAllAsSeen();
  Stream<void> onNotificationsChanged();
  Future<void> clearAllNotifications();
}
