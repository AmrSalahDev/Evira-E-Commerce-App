import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBannerCard extends StatelessWidget {
  final int itemCount;
  const ShimmerBannerCard({super.key, this.itemCount = 1});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Shimmer.fromColors(
          baseColor: context.cardColor,
          highlightColor: context.shimmerHighlightColor,
          child: Container(
            height: 240.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(40.r),
            ),
          ),
        ),
      ),
    );
  }
}
