import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBannerPart extends StatelessWidget {
  const HomeBannerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBannerCubit, HomeBannerState>(
      listener: (context, state) {
        if (state is HomeBannerError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is HomeBannerLoading) {
          return const _ShimmerBannersPart();
        }
        if (state is HomeBannerLoaded) {
          return _BannersPart(state: state);
        }
        if (state is HomeBannerError) {
          return const _ShimmerBannersPart();
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _BannersPart extends StatelessWidget {
  final HomeBannerLoaded state;
  const _BannersPart({required this.state});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 240.h,
        clipBehavior: Clip.none,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      itemCount: state.banners.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return Container(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.h),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: CachedNetworkImage(
                  imageUrl: state.banners[itemIndex].imageUrl,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    state.banners[itemIndex].discount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.largeTextStyle(context),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    state.banners[itemIndex].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.urbanist(
                      fontSize: 23.sp,
                      color: context.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    state.banners[itemIndex].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.urbanist(
                      fontSize: 16.sp,
                      color: context.textColor,
                      fontWeight: FontWeight.w500,
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
                      activeIndex: itemIndex,
                      count: state.banners.length,
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
      },
    );
  }
}

class _ShimmerBannersPart extends StatelessWidget {
  const _ShimmerBannersPart();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
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
    );
  }
}
