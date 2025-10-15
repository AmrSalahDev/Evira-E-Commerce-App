import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/wishlist/ui/bloc/wishlist_bloc.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/category_bar.dart';
import 'package:evira_e_commerce/shared/widgets/product_item.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).wishlist;

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

  int categoryId = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().loadCategories();
    context.read<WishlistBloc>().add(OnFavoritesChanges());
  }

  @override
  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (categoryId == 0) {
          context.read<WishlistBloc>().add(GetProductsFromWishlist());
        } else {
          context.read<WishlistBloc>().add(
            GetProductsFromWishlistByCategory(categoryId),
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
                    context.read<WishlistBloc>().add(
                      GetProductsFromWishlistByCategory(categoryId),
                    );
                  },
                  onAllSelected: () {
                    categoryId = 0;
                    context.read<WishlistBloc>().add(GetProductsFromWishlist());
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
            sliver: BlocConsumer<WishlistBloc, WishlistState>(
              listener: (context, state) {
                if (state is WishlistError) {
                  getIt<ToastService>().showErrorToast(
                    context: context,
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is WishlistLoading) {
                  return const SliverToBoxAdapter(child: ShimmerProducts());
                } else if (state is WishlistLoaded) {
                  return SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      mainAxisExtent: 320.h,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.wishlistProducts[index];
                      return ProductItem(product: product);
                    },
                    itemCount: state.wishlistProducts.length,
                  );
                } else if (state is WishlistError) {
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
    );
  }
}
