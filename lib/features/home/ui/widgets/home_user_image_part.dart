import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeUserImagePart extends StatelessWidget {
  final String? imageUrl;
  const HomeUserImagePart({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        height: 57.h,
        width: 57.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: context.shimmerBaseColor,
          highlightColor: context.shimmerHighlightColor,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.shimmerBaseColor,
            ),
            width: 57.h,
            height: 57.h,
          ),
        ),
        errorWidget: (context, url, error) => Stack(
          children: [
            Container(
              width: 57.h,
              height: 57.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.profileBgColor,
              ),
              child: Assets.icons.profile.svg(
                width: 40.w,
                height: 40.h,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  context.profileIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
