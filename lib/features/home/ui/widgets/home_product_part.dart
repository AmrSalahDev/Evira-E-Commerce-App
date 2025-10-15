import 'dart:math';

import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_product_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/product_item.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductPart extends StatelessWidget {
  const HomeProductPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeProductCubit, HomeProductState>(
      listener: (context, state) {
        if (state is HomeProductError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is HomeProductLoading) {
          return ShimmerProducts();
        }
        if (state is HomeProductLoaded) {
          return _ProductsPart(state);
        }
        if (state is HomeProductError) {
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
  final HomeProductLoaded state;
  const _ProductsPart(this.state);

  @override
  Widget build(BuildContext context) {
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
        final product = state.products[index];
        return ProductItem(product: product);
      },

      itemCount: state.products.length,
    );
  }
}
