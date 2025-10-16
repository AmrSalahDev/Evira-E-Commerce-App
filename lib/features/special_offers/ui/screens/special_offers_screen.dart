import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/special_offers/ui/bloc/special_offers_bloc.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/banner_card.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_banner_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SpecialOffersScreen extends StatefulWidget {
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).specialOffers;

  @override
  List<Widget>? buildActions() {
    return [
      IconButton(
        icon: Assets.icons.roundMenu.svg(
          height: 30.h,
          width: 30.h,
          colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
        ),
        onPressed: () {},
      ),
      SizedBox(width: 10.w),
    ];
  }

  @override
  initState() {
    super.initState();
    context.read<SpecialOffersBloc>().add(GetSpecialOffersEvent());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          context.go(
            AppPaths.noInternet,
            extra: NoInternetScreenArgs(targetPath: AppPaths.specialOffer),
          );
        }
      },
      child: BlocConsumer<SpecialOffersBloc, SpecialOffersState>(
        listener: (context, state) {
          if (state is SpecialOffersError) {
            getIt<ToastService>().showErrorToast(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is SpecialOffersLoading) {
            return const ShimmerBannerCard(itemCount: 5);
          }
          if (state is SpecialOffersLoaded) {
            return ListView.builder(
              clipBehavior: Clip.none,
              itemCount: state.specialOffers.length,
              itemBuilder: (context, index) {
                final banner = state.specialOffers[index];

                return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 240.h,
                    clipBehavior: Clip.none,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                  itemCount: banner.images.length,
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: BannerCard(
                        title: banner.title,
                        discount: banner.discount,
                        description: banner.description,
                        imageUrl: banner.images[itemIndex],
                        bannerIndex: itemIndex,
                        totalBanners: banner.images.length,
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is SpecialOffersError) {
            if (state.message == EviraLang.of(context).noInternetConnection) {
              return const ShimmerBannerCard(itemCount: 5);
            } else {
              return const SizedBox.shrink();
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
