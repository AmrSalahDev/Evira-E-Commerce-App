import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/args/category_view_screen_args.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/category_view/ui/bloc/category_view_bloc.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/product_item.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryViewScreen extends StatefulWidget {
  final CategoryViewScreenArgs args;
  const CategoryViewScreen({super.key, required this.args});

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen>
    with StatefulScreenMixin {
  @override
  String get title => widget.args.categoryName;

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
    context.read<CategoryViewBloc>().add(
      GetCategoryProductsEvent(categoryId: widget.args.categoryId),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      color: context.iconColor,
      backgroundColor: context.containerColor,
      onRefresh: () async {
        context.read<CategoryViewBloc>().add(
          GetCategoryProductsEvent(categoryId: widget.args.categoryId),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            BlocConsumer<CategoryViewBloc, CategoryViewState>(
              listener: (context, state) {
                if (state is CategoryViewError) {
                  getIt<ToastService>().showErrorToast(
                    context: context,
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is CategoryViewLoading) {
                  return const ShimmerProducts();
                }
                if (state is CategoryViewLoaded) {
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
                    itemBuilder: (context, index) {
                      final product = state.categoryProducts[index];
                      return ProductItem(product: product);
                    },

                    itemCount: state.categoryProducts.length,
                  );
                }
                if (state is CategoryViewError) {
                  if (state.message ==
                      EviraLang.of(context).noInternetConnection) {
                    return const ShimmerProducts();
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
