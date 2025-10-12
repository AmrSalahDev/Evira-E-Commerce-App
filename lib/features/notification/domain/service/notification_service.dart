import 'dart:async';
import 'package:evira_e_commerce/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:evira_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationService {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  NotificationService(this._notificationRemoteDataSource);

  Future<void> addNotification(NotificationModel notification) async =>
      await _notificationRemoteDataSource.addNotification(notification);
}
