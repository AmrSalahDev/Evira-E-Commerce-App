import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/banner_card.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_banner_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          return const ShimmerBannerCard();
        }
        if (state is HomeBannerLoaded) {
          return _BannersPart(state: state);
        }
        if (state is HomeBannerError) {
          if (state.message == EviraLang.of(context).noInternetConnection) {
            return const ShimmerBannerCard();
          } else {
            return const SizedBox.shrink();
          }
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
        final banner = state.banners[itemIndex];
        return BannerCard(
          title: banner.title,
          imageUrl: banner.imageUrl,
          discount: banner.discount,
          description: banner.description,
          bannerIndex: itemIndex,
          totalBanners: state.banners.length,
        );
      },
    );
  }
}
