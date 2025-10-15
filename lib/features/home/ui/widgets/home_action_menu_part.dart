import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart';
import 'package:evira_e_commerce/shared/animations/shake_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeActionMenuPart extends StatelessWidget {
  HomeActionMenuPart({super.key});

  final GlobalKey<ShakeAnimationState> _shakeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, count) =>
              count is NotificationLoaded && count.unSeenCount != 0
              ? _shakeKey.currentState?.shake()
              : null,
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            int count = state is NotificationLoaded ? state.unSeenCount : 0;
            return Badge.count(
              isLabelVisible: count != 0,
              count: count,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              offset: Offset(-8.w, 12.h),
              child: IconButton(
                icon: ShakeAnimation(
                  key: _shakeKey,
                  shakes: 5,
                  amplitude: 5.0,
                  duration: Duration(milliseconds: 700),
                  child: Icon(Icons.notifications_outlined),
                ),
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
          onPressed: () {
            context.push(AppPaths.wishlist);
          },
        ),
      ],
    );
  }
}
