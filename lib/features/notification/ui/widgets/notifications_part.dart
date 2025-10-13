import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/dialog_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thanos_snap_effect/thanos_snap_effect.dart';

class NotificationsPart extends StatelessWidget {
  final Map<String, List<NotificationEntity>> grouped;
  const NotificationsPart({super.key, required this.grouped});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 700),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
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
                  return _CustomDismissblePart(
                    notification: notification,
                    child: Container(
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
                    ),
                  );
                }),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CustomDismissblePart extends StatefulWidget {
  final Widget child;
  final NotificationEntity notification;

  const _CustomDismissblePart({
    required this.child,
    required this.notification,
  });

  @override
  State<_CustomDismissblePart> createState() => _CustomDismissblePartState();
}

class _CustomDismissblePartState extends State<_CustomDismissblePart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _snapController;

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.notification.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final confirm = await DialogService.showCustomSimpleDialog(
          context: context,
          barrierDismissible: false,
          title: EviraLang.of(context).confirm,
          content: EviraLang.of(context).areYouSureToDelete,
          confirmText: EviraLang.of(context).delete,
          cancelText: EviraLang.of(context).cancel,
          onConfirm: () => Navigator.of(context).pop(true),
          onCancel: () => Navigator.of(context).pop(false),
        );

        if (confirm != true) return false;

        await _snapController.forward();

        Future.delayed(const Duration(milliseconds: 400), () async {
          if (context.mounted) {
            context.read<NotificationBloc>().add(
              DeleteNotification(widget.notification.id),
            );
            //context.read<NotificationBloc>().add(LoadNotifications());
          }
        });

        // Allow dismissible to remove item after our animation
        return true;
      },

      background: Snappable(
        animation: _snapController,
        outerPadding: const EdgeInsets.all(8),
        style: const SnappableStyle(
          particleSize: SnappableParticleSize.absoluteDp(width: 3, height: 3),
        ),

        child: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ),

      child: widget.child,
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
