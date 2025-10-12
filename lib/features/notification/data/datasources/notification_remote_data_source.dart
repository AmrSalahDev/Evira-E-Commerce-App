import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> addNotification(NotificationModel notification);
  Future<void> updateNotification(int id, bool isSeen);
  Future<void> deleteNotification(int id);
  Future<int> getUnseenCount();
  Future<void> markAllAsSeen();
  Future<void> clearAllNotifications();
  Stream<void> onNotificationsChanged();
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  static const tableName = 'notifications';
  final client = Supabase.instance.client;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final res = await client.from(tableName).select();
    return (res as List).map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  Future<void> addNotification(NotificationModel notification) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;
    await client.from(tableName).insert(notification.toJson(userId));
  }

  @override
  Future<void> updateNotification(int id, bool isSeen) async {
    await client.from(tableName).update({'is_seen': isSeen}).eq('id', id);
  }

  @override
  Future<void> deleteNotification(int id) async {
    await client.from(tableName).delete().eq('id', id);
  }

  @override
  Future<int> getUnseenCount() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return 0;

    final response = await client
        .from(tableName)
        .select('id')
        .eq('user_id', userId)
        .eq('is_seen', false)
        .count(CountOption.exact);

    return response.count;
  }

  @override
  Future<void> markAllAsSeen() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client
        .from(tableName)
        .update({'is_seen': true})
        .eq('user_id', userId)
        .eq('is_seen', false);
  }

  /// Returns a broadcast stream that emits a value each time the notifications
  /// table changes for the current user (insert / update / delete).
  /// The consumer should call getUnseenCount() after an event.
  @override
  Stream<void> onNotificationsChanged() {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return const Stream.empty();

    final controller = StreamController<void>.broadcast();
    final channel = client.channel('notifications-channel');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: tableName,
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: userId,
      ),
      callback: (payload) {
        controller.add(null); // notify cubit
      },
    );

    channel.subscribe();

    controller.onCancel = () async {
      await channel.unsubscribe();
    };

    return controller.stream;
  }

  @override
  Future<void> clearAllNotifications() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;
    await client.from(tableName).delete().eq('user_id', userId);
  }
}
