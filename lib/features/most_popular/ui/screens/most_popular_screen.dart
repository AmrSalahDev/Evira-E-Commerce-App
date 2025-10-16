import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/most_popular/ui/bloc/most_popular_bloc.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/category_bar.dart';
import 'package:evira_e_commerce/shared/widgets/product_item.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';

class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).mostPopular;

  int categoryId = 0;

  @override
  List<Widget>? buildActions() {
    return [
      IconButton(
        icon: Assets.icons.search.svg(
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
  void initState() {
    super.initState();
    context.read<CategoryCubit>().loadCategories();
    context.read<MostPopularBloc>().add(GetMostPopularProducts());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          context.go(
            AppPaths.noInternet,
            extra: NoInternetScreenArgs(targetPath: AppPaths.mostPopular),
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          if (categoryId == 0) {
            context.read<MostPopularBloc>().add(GetMostPopularProducts());
          } else {
            context.read<MostPopularBloc>().add(
              GetMostPopularProducts(categoryId: categoryId),
            );
          }
        },
        color: context.iconColor,
        backgroundColor: context.containerColor,
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            SliverStickyHeader(
              header: Column(
                children: [
                  CategoryBar(
                    onCategorySelected: (categoryId) {
                      this.categoryId = categoryId;
                      context.read<MostPopularBloc>().add(
                        GetMostPopularProducts(categoryId: categoryId),
                      );
                    },
                    onAllSelected: () {
                      categoryId = 0;
                      context.read<MostPopularBloc>().add(
                        GetMostPopularProducts(),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
              sliver: BlocConsumer<MostPopularBloc, MostPopularState>(
                listener: (context, state) {
                  if (state is MostPopularError) {
                    getIt<ToastService>().showErrorToast(
                      context: context,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is MostPopularLoading) {
                    return const SliverToBoxAdapter(child: ShimmerProducts());
                  } else if (state is MostPopularLoaded) {
                    return SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 20.h,
                        mainAxisExtent: 320.h,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductItem(product: product);
                      },
                      itemCount: state.products.length,
                    );
                  } else if (state is MostPopularError) {
                    if (state.message ==
                        EviraLang.of(context).noInternetConnection) {
                      return const SliverToBoxAdapter(child: ShimmerProducts());
                    } else {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
