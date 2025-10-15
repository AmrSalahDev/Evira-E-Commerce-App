import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/core/utils/notification_utils.dart';
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart';
import 'package:evira_e_commerce/features/notification/ui/widgets/notifications_part.dart';
import 'package:evira_e_commerce/features/notification/ui/widgets/shimmer_notifications_part.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificationScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).notification;

  @override
  List<Widget>? buildActions() {
    return [
      IconButton(
        icon: Assets.icons.roundMenu.svg(
          height: 30.h,
          width: 30.h,
          colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
        ),
        onPressed: () {},
      ),
      SizedBox(width: 10.w),
    ];
  }

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(MarkNotificationsAsSeen());
    context.read<NotificationBloc>().add(ListenNotificationChanges());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          context.go(
            AppPaths.noInternet,
            extra: NoInternetScreenArgs(targetPath: AppPaths.notification),
          );
        }
      },
      child: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationError) {
            getIt<ToastService>().showErrorToast(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const ShimmerNotificationsPart();
          } else if (state is NotificationLoaded &&
              state.notifications.isNotEmpty) {
            final grouped = NotificationUtils.groupNotificationsByDate(
              state.notifications,
            );
            return NotificationsPart(grouped: grouped);
          } else if (state is NotificationLoaded &&
              state.notifications.isEmpty) {
            return Center(
              child: Text(
                EviraLang.of(context).noNotifications,
                style: GoogleFonts.urbanist(
                  color: context.textColor,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (state is NotificationError) {
            if (state.message == EviraLang.of(context).noInternetConnection) {
              return const ShimmerNotificationsPart();
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
