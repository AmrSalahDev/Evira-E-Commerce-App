import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerCard extends StatelessWidget {
  final String title;
  final String discount;
  final String imageUrl;
  final String description;
  final int bannerIndex;
  final int totalBanners;
  const BannerCard({
    super.key,

    required this.bannerIndex,
    required this.totalBanners,
    required this.title,
    required this.discount,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.h,
      padding: EdgeInsets.only(left: 25.w, right: 15.w, top: 15.h),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: double.infinity,
              width: context.screenWidth * 0.5,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Flexible(
                child: Text(
                  discount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.largeTextStyle(context),
                ),
              ),
              SizedBox(height: 10.h),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(
                    fontSize: 23.sp,
                    color: context.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: context.screenWidth * 0.45,
                child: Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(
                    fontSize: 16.sp,
                    color: context.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                AnimatedSmoothIndicator(
                  activeIndex: bannerIndex,
                  count: totalBanners,
                  effect: ExpandingDotsEffect(
                    dotWidth: 7.w,
                    dotHeight: 7.h,
                    activeDotColor: context.iconColor,
                    dotColor: context.gray300,
                  ),
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
