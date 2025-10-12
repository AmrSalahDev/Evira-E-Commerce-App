part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unSeenCount;

  const NotificationLoaded({
    required this.notifications,
    required this.unSeenCount,
  });

  @override
  List<Object?> get props => [notifications, unSeenCount];
}

class NotificationCountLoaded extends NotificationState {
  final int count;
  const NotificationCountLoaded(this.count);
  @override
  List<Object?> get props => [count];
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError({required this.message});

  @override
  List<Object?> get props => [message];
}
