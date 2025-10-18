import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_product_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_app_bar_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_banner_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_bottom_navigation_bar.dart';
import 'package:evira_e_commerce/shared/widgets/category_bar.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_category_grid_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_product_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_search_bar_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/see_all_widget_part.dart';
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart';
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with StatefulScreenMixin {
  final client = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
    context.read<HomeAppBarCubit>().loadUserInfo();
    context.read<GreetingCubit>().startGreeting();
    context.read<NotificationBloc>().add(ListenNotificationChanges());
    context.read<HomeBannerCubit>().loadBanners();
    context.read<CategoryCubit>().loadCategories();
    context.read<HomeProductCubit>().loadAllProducts();
  }

  @override
  bool get showAppBar => false;

  @override
  bool get applyPaddingForBottomNavigationBar => false;

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
            HomeSearchBarPart(
              onTap: () {
                context.push(AppPaths.search);
              },
            ),
            SizedBox(height: 30.h),
            SeeAllWidgetPart(
              title: EviraLang.of(context).specialOffers,
              onTap: () {
                context.push(AppPaths.specialOffer);
              },
            ),
            SizedBox(height: 30.h),
            HomeBannerPart(),
            SizedBox(height: 30.h),
            HomeCategoryGridPart(),
            SizedBox(height: 30.h),
            SeeAllWidgetPart(
              title: EviraLang.of(context).mostPopular,
              onTap: () {
                context.push(AppPaths.mostPopular);
              },
            ),
            SizedBox(height: 20.h),
            CategoryBar(
              onCategorySelected: (categoryId) async {
                await context.read<HomeProductCubit>().getProductsByCategoryId(
                  categoryId: categoryId,
                );
              },
              onAllSelected: () async =>
                  await context.read<HomeProductCubit>().loadAllProducts(),
            ),
            SizedBox(height: 20.h),
            HomeProductPart(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget? buildBottomNavigationBar() {
    return HomeBottomNavigationBar();
  }
}
