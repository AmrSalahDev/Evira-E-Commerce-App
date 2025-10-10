import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_product_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/favorite_button.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeProductPart extends StatelessWidget {
  const HomeProductPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeProductCubit, HomeProductState>(
      listener: (context, state) {
        if (state is HomeProductError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is HomeProductLoading) {
          return _ShimmerProductPart();
        }
        if (state is HomeProductLoaded) {
          return _ProductsPart(state);
        }
        if (state is HomeProductError) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ProductsPart extends StatelessWidget {
  final HomeProductLoaded state;
  const _ProductsPart(this.state);

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
      itemBuilder: (context, index) => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                height: 200.h,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),

                child: LayoutBuilder(
                  builder: (context, constraints) => CachedNetworkImage(
                    imageUrl: state.products[index].imageUrl,
                    fit: BoxFit.contain,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    alignment: Alignment.center,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: context.cardColor,
                      highlightColor: context.shimmerHighlightColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: context.cardColor,
                        ),
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                state.products[index].name,
                style: GoogleFonts.urbanist(
                  fontSize: 20.sp,
                  color: context.textColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: context.iconColor, size: 20.sp),
                  SizedBox(width: 5.w),
                  Text(
                    state.products[index].rate.toString(),
                    style: GoogleFonts.urbanist(
                      fontSize: 16.sp,
                      color: context.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 7.w),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 16.sp, color: context.textColor),
                  ),
                  SizedBox(width: 7.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: context.cardColor,
                    ),
                    child: Text.rich(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        text: state.products[index].sold.toString(),
                        style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          color: context.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${EviraLang.of(context).sold}',
                            style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                              color: context.textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                "\$${state.products[index].price}",
                style: GoogleFonts.urbanist(
                  fontSize: 20.sp,
                  color: context.textColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Positioned(
            top: 12.h,
            right: 12.w,
            child: FavoriteButton(
              heartColor: Colors.white,
              size: 22.sp,
              onFavorited: () {},
              onUnfavorited: () {},
            ),
          ),
        ],
      ),

      itemCount: state.products.length,
    );
  }
}

class _ShimmerProductPart extends StatelessWidget {
  const _ShimmerProductPart();

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
            height: 200,
            width: double.infinity,
            borderRadius: 30.r,
            shimmerBaseColor: context.cardColor,
          ),
          SizedBox(height: 10.h),
          ShimmerBox(
            height: 15,
            width: double.infinity,
            shimmerBaseColor: context.cardColor,
          ),
          SizedBox(height: 10.h),
          ShimmerBox(
            height: 15,
            width: 100,
            shimmerBaseColor: context.cardColor,
          ),
          SizedBox(height: 10.h),
          ShimmerBox(
            height: 15,
            width: 50,
            shimmerBaseColor: context.cardColor,
          ),
        ],
      ),
    );
  }
}
