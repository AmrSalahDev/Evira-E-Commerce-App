import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;
  int? _selectedCategoryId;
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
    if (_isBottom && !_isLoadingMore) _loadMore();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _loadMore() {
    final state = context.read<HomeProductsBloc>().state;
    if (state is HomeProductsLoading) return;

    _isLoadingMore = true;
    _currentPage++;

    context.read<HomeProductsBloc>().add(
      LoadMoreHomeProducts(
        limit: 10,
        page: _currentPage,
        categoryId: _selectedCategoryId,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NetworkCubit, NetworkState>(
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
              SliverStickyHeader(
                header: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  color: context.backgroundColor,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      const HomeAppBarPart(),
                      SizedBox(height: 30.h),
                      HomeSearchBarPart(
                        onTap: () => context.push(AppPaths.search),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        SeeAllWidgetPart(
                          title: EviraLang.of(context).specialOffers,
                          onTap: () => context.push(AppPaths.specialOffer),
                        ),
                        SizedBox(height: 30.h),
                        const HomeBannerPart(),
                        const HomeCategoryGridPart(),
                        SizedBox(height: 30.h),
                        SeeAllWidgetPart(
                          title: EviraLang.of(context).mostPopular,
                          onTap: () => context.push(AppPaths.mostPopular),
                        ),
                        SizedBox(height: 20.h),
                        CategoryBar(
                          onCategorySelected: (categoryId) {
                            _selectedCategoryId = categoryId == 0
                                ? null
                                : categoryId;
                            _currentPage =
                                1; // Reset page when switching categories
                            context.read<HomeProductsBloc>().add(
                              LoadHomeProducts(
                                limit: 10,
                                page: _currentPage,
                                categoryId: _selectedCategoryId,
                              ),
                            );
                          },
                          onAllSelected: () {
                            _selectedCategoryId = null;
                            _currentPage =
                                1; // Reset page when switching categories
                            context.read<HomeProductsBloc>().add(
                              LoadHomeProducts(limit: 10, page: _currentPage),
                            );
                          },
                        ),

                        const HomeProductPart(),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }
}
