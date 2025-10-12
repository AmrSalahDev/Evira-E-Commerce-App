import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/core/utils/notification_utils.dart';
import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

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
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return _ShimmerNotificationsPart();
        } else if (state is NotificationLoaded &&
            state.notifications.isNotEmpty) {
          final grouped = NotificationUtils.groupNotificationsByDate(
            state.notifications,
          );

          return _NotificationsPart(grouped: grouped);
        } else {
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
        }
      },
    );
  }
}

class _ShimmerNotificationsPart extends StatelessWidget {
  const _ShimmerNotificationsPart();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: 15.h),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: context.textFieldColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ShimmerBox(height: 70.h, width: 70.h, borderRadius: 100),
            SizedBox(width: 16.w),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerBox(height: 15.h, width: context.screenWidth * 0.4),
                  SizedBox(height: 10.h),
                  ShimmerBox(height: 15.h, width: context.screenWidth * 0.6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsPart extends StatelessWidget {
  const _NotificationsPart({required this.grouped});
  final Map<String, List<NotificationEntity>> grouped;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: grouped.entries.map((entry) {
        final sectionTitle = entry.key;
        final sectionItems = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Text(
              sectionTitle,
              style: GoogleFonts.urbanist(
                color: context.textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25.h),
            ...sectionItems.map((notification) {
              return Container(
                margin: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                  color: context.textFieldColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NotificationIconPart(notification: notification),
                    SizedBox(width: 16.w),
                    _NotificationTitleAndMessagePart(notification),
                  ],
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }
}

class _NotificationTitleAndMessagePart extends StatelessWidget {
  final NotificationEntity notification;
  const _NotificationTitleAndMessagePart(this.notification);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              color: context.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.h,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            notification.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              color: context.textColor.withAlpha(180),
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationIconPart extends StatelessWidget {
  final NotificationEntity notification;
  const _NotificationIconPart({required this.notification});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35.r,
      backgroundColor: context.iconColor,
      child: Image.asset(
        notification.icon,
        height: 30.h,
        width: 30.h,
        color: context.backgroundColor,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.notifications,
          color: context.backgroundColor,
          size: 30.h,
        ),
      ),
    );
  }
}
