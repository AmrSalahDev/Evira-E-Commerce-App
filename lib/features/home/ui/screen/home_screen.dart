import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/features/home/ui/bloc/home_products_bloc.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with StatefulScreenMixin {
  late final ScrollController _scrollController;
  int _currentPage = 1;
  bool _isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<HomeAppBarCubit>().loadUserInfo();
    context.read<GreetingCubit>().startGreeting();
    context.read<NotificationBloc>().add(ListenNotificationChanges());
    context.read<HomeBannerCubit>().loadBanners();
    context.read<CategoryCubit>().loadCategories();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    final state = context.read<HomeProductsBloc>().state;
    if (state is HomeProductsLoading) return; // already loading

    _isLoadingMore = true;
    _currentPage++;
    context.read<HomeProductsBloc>().add(
      LoadMoreHomeProducts(limit: 10, page: _currentPage),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      child: BlocListener<HomeProductsBloc, HomeProductsState>(
        listener: (context, state) {
          if (state is HomeProductsLoaded || state is HomeProductsError) {
            _isLoadingMore = false; // Reset after load completes or fails
          }
        },
        child: CustomScrollView(
          controller: _scrollController,
          clipBehavior: Clip.none,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  HomeAppBarPart(),
                  SizedBox(height: 30.h),
                  HomeSearchBarPart(onTap: () => context.push(AppPaths.search)),
                  SizedBox(height: 30.h),
                  SeeAllWidgetPart(
                    title: EviraLang.of(context).specialOffers,
                    onTap: () => context.push(AppPaths.specialOffer),
                  ),
                  SizedBox(height: 30.h),
                  HomeBannerPart(),
                  SizedBox(height: 30.h),
                  HomeCategoryGridPart(),
                  SizedBox(height: 30.h),
                  SeeAllWidgetPart(
                    title: EviraLang.of(context).mostPopular,
                    onTap: () => context.push(AppPaths.mostPopular),
                  ),
                  SizedBox(height: 20.h),
                  CategoryBar(
                    defaultCategoryIndex: 0,
                    onCategorySelected: (categoryId) {
                      _currentPage = 1; // Reset page when switching categories
                      context.read<HomeProductsBloc>().add(
                        LoadHomeProducts(
                          limit: 10,
                          page: _currentPage,
                          categoryId: categoryId == 0 ? null : categoryId,
                        ),
                      );
                    },
                    onAllSelected: () {
                      _currentPage = 1;
                      context.read<HomeProductsBloc>().add(
                        LoadHomeProducts(limit: 10, page: _currentPage),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            SliverToBoxAdapter(child: HomeProductPart()),
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
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
