import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerProducts extends StatelessWidget {
  const ShimmerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        mainAxisExtent: 320.h,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerBox(
            height: 200.h,
            width: double.infinity,
            borderRadius: 30.r,
            shimmerBaseColor: context.cardColor,
          ),
          SizedBox(height: 10.h),
          ShimmerBox(
            height: 15.h,
            width: double.infinity,
            shimmerBaseColor: context.cardColor,
          ),
          SizedBox(height: 10.h),
          ShimmerBox(
            height: 15.h,
            width: 100.w,
            shimmerBaseColor: context.cardColor,
          ),
          SizedBox(height: 10.h),
          ShimmerBox(
            height: 15.h,
            width: 50.w,
            shimmerBaseColor: context.cardColor,
          ),
        ],
      ),
    );
  }
}
