import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart';
import 'package:evira_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/clear_all_notificatons_usecase.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/get_unseen_notifications_count_usecase.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/listen_notifications_changes_usecase.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/mark_notifications_as_seen_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

@lazySingleton
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService notificationService;
  final GetNotificationsUsecase getNotificationsUsecase;
  final ClearAllNotificatonsUsecase clearAllNotificatonsUsecase;
  final MarkNotificationsAsSeenUsecase markNotificationsAsSeenUsecase;
  final GetUnseenNotificationsCountUseCase getUnseenNotificationsCountUsecase;
  final ListenNotificationsChangesUsecase listenChanges;
  StreamSubscription? _sub;

  NotificationBloc(
    this.notificationService,
    this.getNotificationsUsecase,
    this.clearAllNotificatonsUsecase,
    this.markNotificationsAsSeenUsecase,
    this.getUnseenNotificationsCountUsecase,
    this.listenChanges,
  ) : super(NotificationInitial()) {
    // Load notifications
    on<LoadNotifications>((event, emit) async {
      debugPrint('Load notifications');
      emit(NotificationLoading());
      try {
        final notifications = await getNotificationsUsecase.call();
        final count = await getUnseenNotificationsCountUsecase.call();
        emit(
          NotificationLoaded(notifications: notifications, unSeenCount: count),
        );
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });

    // Add notification
    on<AddNotification>((event, emit) async {
      debugPrint('Add notification');

      try {
        await notificationService.addNotification(event.notification);
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });

    // Mark all as seen
    on<MarkNotificationsAsSeen>((event, emit) async {
      debugPrint('Mark notifications as seen');
      try {
        await markNotificationsAsSeenUsecase.call();
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });

    //  Get unseen count
    on<GetUnseenCount>((event, emit) async {
      debugPrint('Get unseen count');
      try {
        final count = await getUnseenNotificationsCountUsecase.call();
        emit(NotificationCountLoaded(count));
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });

    // Realtime listener for Supabase changes
    on<ListenNotificationChanges>((event, emit) async {
      debugPrint('Listen notification changes');
      add(LoadNotifications());
      await _sub?.cancel();
      _sub = listenChanges.call().listen((_) async {
        add(LoadNotifications());
      });
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
