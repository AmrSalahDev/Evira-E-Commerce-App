import 'dart:io';

import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ImageFileLoading extends StatelessWidget {
  final File file;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? onLoading;
  final Widget? onError;

  const ImageFileLoading({
    super.key,
    required this.file,
    required this.width,
    required this.height,
    required this.fit,
    this.onLoading,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: frame != null
              ? child
              : onLoading ??
                    Shimmer.fromColors(
                      baseColor: context.shimmerBaseColor,
                      highlightColor: context.shimmerHighlightColor,
                      child: Container(
                        width: width,
                        height: height,
                        color: context.shimmerBaseColor,
                      ),
                    ),
          // FadeShimmer.round(
          //   size: height,
          //   baseColor: context.shimmerBaseColor,
          //   highlightColor: context.shimmerHighlightColor,
          // ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return onError ??
            Icon(Icons.error, color: context.iconColor, size: 50.h);
      },
    );
  }
}
