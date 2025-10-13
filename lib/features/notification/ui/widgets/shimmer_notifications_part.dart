import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class ShimmerNotificationsPart extends StatelessWidget {
  const ShimmerNotificationsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
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
