import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/features/home/ui/bloc/home_products_bloc.dart';
import 'package:evira_e_commerce/shared/widgets/product_item.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductPart extends StatelessWidget {
  const HomeProductPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeProductsBloc, HomeProductsState>(
      listener: (context, state) {
        if (state is HomeProductsError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is HomeProductsLoading) {
          // First page loading shimmer
          return ShimmerProducts();
        }

        if (state is HomeProductsLoaded) {
          return _ProductsPart(state);
        }

        if (state is HomeProductsError) {
          if (state.message == EviraLang.of(context).noInternetConnection) {
            return ShimmerProducts();
          } else {
            return const SizedBox.shrink();
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _ProductsPart extends StatelessWidget {
  final HomeProductsLoaded state;
  const _ProductsPart(this.state);

  @override
  Widget build(BuildContext context) {
    final products = state.products;

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 20.h,
            mainAxisExtent: 320.h,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductItem(product: product);
          },
        ),

        // Show bottom loader while loading more
        if (!state.hasReachedEnd)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: const CircularProgressIndicator(),
          )
        else
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              EviraLang.of(context).noMoreProducts,
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ),
      ],
    );
  }
}
