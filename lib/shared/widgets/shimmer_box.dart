import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final EdgeInsetsGeometry? margin;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor ?? context.shimmerBaseColor,
      highlightColor: shimmerHighlightColor ?? context.shimmerHighlightColor,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: shimmerBaseColor ?? context.shimmerBaseColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
        ),
      ),
    );
  }
}
