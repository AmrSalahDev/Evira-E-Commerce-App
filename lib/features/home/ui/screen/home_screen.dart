import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_app_bar_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_search_bar_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/see_all_widget_part.dart';
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with StatefulScreenMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeAppBarCubit>().loadUserInfo();
    context.read<GreetingCubit>().startGreeting();
  }

  @override
  bool get showAppBar => false;

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          HomeAppBarPart(),
          SizedBox(height: 30.h),
          HomeSearchBarPart(),
          SizedBox(height: 30.h),
          SeeAllWidgetPart(title: EviraLang.of(context).specialOffers),
          SizedBox(height: 30.h),
          CarouselSliderPart(),
        ],
      ),
    );
  }
}

class CarouselSliderPart extends StatelessWidget {
  const CarouselSliderPart({super.key});

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
      itemCount: 5,
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
                child: Assets.images.homeSliderImage.image(
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
                  Text("30%", style: AppStyles.largeTextStyle(context)),
                  SizedBox(height: 10.h),
                  Text(
                    "Today's Special!",
                    style: GoogleFonts.urbanist(
                      fontSize: 23.sp,
                      color: context.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Get discount for every\norder. only valid for today",
                    style: AppStyles.smallTextStyle18(context),
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
                      count: 5,
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
