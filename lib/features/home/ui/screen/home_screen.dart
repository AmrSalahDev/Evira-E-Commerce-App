import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_category_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_banner_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_app_bar_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_category_grid_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_search_bar_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/see_all_widget_part.dart';
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    context.read<HomeBannerCubit>().loadBanners();
    context.read<HomeCategoryCubit>().loadCategories();
  }

  @override
  bool get showAppBar => false;

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          context.go(
            AppPaths.noInternet,
            extra: NoInternetScreenArgs(targetPath: AppPaths.home),
          );
        }
      },
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            HomeAppBarPart(),
            SizedBox(height: 30.h),
            HomeSearchBarPart(),
            SizedBox(height: 30.h),
            SeeAllWidgetPart(title: EviraLang.of(context).specialOffers),
            SizedBox(height: 30.h),
            HomeBannerPart(),
            SizedBox(height: 30.h),
            HomeCategoryGridPart(),
            SizedBox(height: 30.h),
            SeeAllWidgetPart(title: EviraLang.of(context).mostPopular),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
