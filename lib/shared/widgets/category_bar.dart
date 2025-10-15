import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CategoryBar extends StatelessWidget {
  final Function(int categoryId) onCategorySelected;
  final Function() onAllSelected;

  const CategoryBar({
    super.key,
    required this.onCategorySelected,
    required this.onAllSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryError) {
            getIt<ToastService>().showErrorToast(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const _ShimmerCategoriesPart();
          }
          if (state is CategoryLoaded) {
            return _CategoriesPart(
              state: state,
              onCategorySelected: onCategorySelected,
              onAllSelected: onAllSelected,
            );
          }
          if (state is CategoryError) {
            return const _ShimmerCategoriesPart();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _CategoriesPart extends StatefulWidget {
  final CategoryLoaded state;
  final Function(int categoryId) onCategorySelected;
  final Function() onAllSelected;

  const _CategoriesPart({
    required this.state,
    required this.onCategorySelected,
    required this.onAllSelected,
  });

  @override
  State<_CategoriesPart> createState() => _CategoriesPartState();
}

class _CategoriesPartState extends State<_CategoriesPart> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.state.categories.length + 1, // +1 for "All"
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          // Handle first item as "All"
          final name = index == 0
              ? EviraLang.of(context).all
              : widget.state.categories[index - 1].name; // shift index by -1

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              if (index != 0) {
                widget.onCategorySelected(
                  widget.state.categories[index - 1].id,
                );
              } else {
                widget.onAllSelected();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Chip(
                label: Text(
                  name,
                  style: GoogleFonts.urbanist(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textColor,
                  ),
                ),
                backgroundColor: isSelected
                    ? context.cardColor
                    : context.backgroundColor,
                side: BorderSide(color: context.cardColor),
                shape: const StadiumBorder(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ShimmerCategoriesPart extends StatelessWidget {
  const _ShimmerCategoriesPart();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Shimmer.fromColors(
            baseColor: context.cardColor,
            highlightColor: context.shimmerHighlightColor,
            child: Chip(
              label: Container(
                height: 30.h,
                width: 100.w,
                color: context.cardColor,
              ),
              backgroundColor: context.backgroundColor,
              side: BorderSide(color: context.cardColor),
              shape: StadiumBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
