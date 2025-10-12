part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class AddNotification extends NotificationEvent {
  final NotificationModel notification;
  AddNotification(this.notification);
}

class ClearNotifications extends NotificationEvent {}

class MarkNotificationsAsSeen extends NotificationEvent {}

class GetUnseenCount extends NotificationEvent {}

class ListenNotificationChanges extends NotificationEvent {}
