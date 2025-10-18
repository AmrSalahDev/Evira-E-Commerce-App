import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/not_found_products_part.dart';
import 'package:evira_e_commerce/shared/widgets/product_item.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultPart extends StatelessWidget {
  final String keyword;
  const SearchResultPart({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchResultsBloc, SearchResultsState>(
      listener: (context, state) {
        if (state is SearchResultError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is SearchResultLoading) {
          return SliverToBoxAdapter(child: const ShimmerProducts());
        } else if (state is SearchResultLoaded && state.products.isEmpty) {
          return SliverToBoxAdapter(
            child: NotFoundProductsPart(keyword: keyword),
          );
        } else if (state is SearchResultLoaded) {
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              mainAxisExtent: 320.h,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductItem(product: product);
            },
          );
        } else if (state is SearchResultError) {
          if (state.message == EviraLang.of(context).noInternetConnection) {
            return SliverToBoxAdapter(child: const ShimmerProducts());
          } else {
            return SliverToBoxAdapter(child: const SizedBox.shrink());
          }
        }
        return SliverToBoxAdapter(child: const SizedBox.shrink());
      },
    );
  }
}
