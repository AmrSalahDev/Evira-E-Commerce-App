import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeCategoryGridPart extends StatelessWidget {
  const HomeCategoryGridPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const _ShimmerGridViewPart();
        } else if (state is CategoryLoaded) {
          return _CategoryGridViewPart(state: state);
        } else if (state is CategoryError) {
          return const _ShimmerGridViewPart();
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _CategoryGridViewPart extends StatelessWidget {
  final CategoryLoaded state;
  const _CategoryGridViewPart({required this.state});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 25.w,
        mainAxisSpacing: 15.h,
        mainAxisExtent: 120.h,
      ),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 75.h,
              width: 75.h,
              alignment: Alignment.center,
              padding: EdgeInsets.all(21.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.cardColor,
              ),
              child: CachedNetworkImage(
                imageUrl: state.categories[index].iconUrl,
                color: context.iconColor,
                height: 70.h,
                width: 70.h,
                fit: BoxFit.contain,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: context.cardColor,
                  highlightColor: context.shimmerHighlightColor,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.cardColor,
                    ),
                    width: 75.h,
                    height: 75.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              state.categories[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                color: context.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerGridViewPart extends StatelessWidget {
  const _ShimmerGridViewPart();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 25.w,
        mainAxisSpacing: 15.h,
        mainAxisExtent: 120.h,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: context.cardColor,
              highlightColor: context.shimmerHighlightColor,
              child: Container(
                height: 75.h,
                width: 75.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.cardColor,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Shimmer.fromColors(
              baseColor: context.cardColor,
              highlightColor: context.shimmerHighlightColor,
              child: Container(
                height: 20.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
