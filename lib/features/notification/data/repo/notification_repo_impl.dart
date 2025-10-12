import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

import '../datasources/notification_remote_data_source.dart';

@LazySingleton(as: NotificationRepo)
class NotificationRepoImpl implements NotificationRepo {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepoImpl(this.remoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async =>
      await remoteDataSource.getNotifications();

  @override
  Future<void> updateNotification(int id, bool isSeen) async =>
      await remoteDataSource.updateNotification(id, isSeen);

  @override
  Future<void> deleteNotification(int id) async =>
      await remoteDataSource.deleteNotification(id);

  @override
  Future<int> getUnseenCount() async {
    return remoteDataSource.getUnseenCount();
  }

  @override
  Future<void> markAllAsSeen() async {
    await remoteDataSource.markAllAsSeen();
  }

  @override
  Stream<void> onNotificationsChanged() {
    return remoteDataSource.onNotificationsChanged();
  }

  @override
  Future<void> clearAllNotifications() async {
    await remoteDataSource.clearAllNotifications();
  }
}
