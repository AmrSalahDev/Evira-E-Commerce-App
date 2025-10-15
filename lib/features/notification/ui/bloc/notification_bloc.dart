import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart';
import 'package:evira_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/clear_all_notificatons_usecase.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/delete_notification_usecase.dart';
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
  final DeleteNotificationUsecase deleteNotificationUsecase;
  final ListenNotificationsChangesUsecase listenChanges;
  StreamSubscription? _sub;

  NotificationBloc(
    this.notificationService,
    this.getNotificationsUsecase,
    this.clearAllNotificatonsUsecase,
    this.markNotificationsAsSeenUsecase,
    this.getUnseenNotificationsCountUsecase,
    this.listenChanges,
    this.deleteNotificationUsecase,
  ) : super(NotificationInitial()) {
    // Load notifications
    on<LoadNotifications>((event, emit) async {
      debugPrint('Load notifications');
      await AppUtils.handleCode(
        code: () async {
          emit(NotificationLoading());
          final notifications = await getNotificationsUsecase.call();
          final count = await getUnseenNotificationsCountUsecase.call();
          emit(
            NotificationLoaded(
              notifications: notifications,
              unSeenCount: count,
            ),
          );
        },
        onNoInternet: (message) {
          emit(NotificationError(message: message));
        },
        onError: (message) {
          emit(NotificationError(message: message));
        },
      );
    });

    // Add notification
    on<AddNotification>((event, emit) async {
      debugPrint('Add notification');
      await AppUtils.handleCode(
        code: () async {
          await notificationService.addNotification(event.notification);
        },
        onNoInternet: (message) {
          emit(NotificationError(message: message));
        },
        onError: (message) {
          emit(NotificationError(message: message));
        },
      );
    });

    // Mark all as seen
    on<MarkNotificationsAsSeen>((event, emit) async {
      debugPrint('Mark notifications as seen');
      await AppUtils.handleCode(
        code: () async {
          await markNotificationsAsSeenUsecase.call();
        },
        onNoInternet: (message) {
          NotificationError(message: message);
        },
        onError: (message) {
          emit(NotificationError(message: message));
        },
      );
    });

    //  Get unseen count
    on<GetUnseenCount>((event, emit) async {
      debugPrint('Get unseen count');
      await AppUtils.handleCode(
        code: () async {
          final count = await getUnseenNotificationsCountUsecase.call();
          emit(NotificationCountLoaded(count));
        },
        onNoInternet: (message) {
          emit(NotificationError(message: message));
        },
        onError: (message) {
          emit(NotificationError(message: message));
        },
      );
    });

    on<DeleteNotification>((event, emit) async {
      debugPrint('Delete notification');
      await AppUtils.handleCode(
        code: () async {
          await deleteNotificationUsecase.call(event.id);
          add(LoadNotifications());
        },
        onNoInternet: (message) {
          emit(NotificationError(message: message));
        },
        onError: (message) {
          emit(NotificationError(message: message));
        },
      );
    });

    // Realtime listener for Supabase changes
    on<ListenNotificationChanges>((event, emit) async {
      debugPrint('Listen notification changes');
      await AppUtils.handleCode(
        code: () async {
          add(LoadNotifications());
          await _sub?.cancel();
          _sub = listenChanges.call().listen((_) async {
            add(LoadNotifications());
          });
        },
        onNoInternet: (message) {
          emit(NotificationError(message: message));
        },
        onError: (message) {
          emit(NotificationError(message: message));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
