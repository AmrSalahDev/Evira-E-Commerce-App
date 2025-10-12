import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeActionMenuPart extends StatelessWidget {
  const HomeActionMenuPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<NotificationBloc, NotificationState, int>(
          selector: (state) =>
              state is NotificationLoaded ? state.unSeenCount : 0,
          builder: (context, count) {
            return Badge.count(
              isLabelVisible: count != 0,
              count: count,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              offset: Offset(-8.w, 12.h),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                iconSize: 32.h,
                color: context.iconColor,
                onPressed: () {
                  context.push(AppPaths.notification);
                },
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border_outlined),
          iconSize: 32.h,
          color: context.iconColor,
          onPressed: () async {
            await getIt<NotificationService>().addNotification(
              NotificationModel(
                title: 'Notification Title',
                message: 'Notification Message',
                icon: 'assets/images/evira.png',
                date: DateTime.now(),
              ),
            );
          },
        ),
      ],
    );
  }
}
