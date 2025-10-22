import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/search/domain/entities/filter_entity.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/cubit/filter_cubit.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/custom_slider_part.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/category_bar.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/rate_bar.dart';
import 'package:evira_e_commerce/shared/widgets/sort_by_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheetPart extends StatefulWidget {
  final String keyword;
  final BuildContext parentContext;
  const FilterBottomSheetPart({
    super.key,
    required this.keyword,
    required this.parentContext,
  });

  @override
  State<FilterBottomSheetPart> createState() => _FilterBottomSheetPartState();
}

class _FilterBottomSheetPartState extends State<FilterBottomSheetPart> {
  int? selectedCategoryId;
  int? selectedSortIndex;
  int? selectedRatingIndex;
  double minPrice = 0;
  double maxPrice = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().loadCategories();
  }

  void _resetFilters() {
    context.read<FilterCubit>().clearFilters();
    Navigator.pop(context);
  }

  void _applyFilters() {
    final filter = FilterEntity(
      categoryId: selectedCategoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortIndex: selectedSortIndex,
      ratingIndex: selectedRatingIndex,
    );

    widget.parentContext.read<SearchResultsBloc>().add(
      ApplyFiltersEvent(filter: filter, keyword: widget.keyword),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    height: 5.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    EviraLang.of(context).sortAndFilter,
                    style: GoogleFonts.urbanist(
                      color: context.textColor,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Divider(color: context.dividerColor, thickness: 1.5),
            SizedBox(height: 20.h),
            Text(
              EviraLang.of(context).categories,
              style: GoogleFonts.urbanist(
                color: context.textColor,
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            BlocSelector<FilterCubit, FilterState, int>(
              selector: (state) {
                return state.selectedCategoryIndex ?? 0;
              },
              builder: (context, selectedCategoryId) {
                return CategoryBar(
                  defaultCategoryIndex: selectedCategoryId,
                  onCategorySelected: (categoryId) {
                    context.read<FilterCubit>().selectCategory(categoryId);
                  },
                  onAllSelected: () {
                    selectedCategoryId = 0;
                    context.read<FilterCubit>().selectCategory(0);
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              EviraLang.of(context).priceRange,
              style: GoogleFonts.urbanist(
                color: context.textColor,
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            BlocSelector<FilterCubit, FilterState, RangeValues>(
              selector: (state) {
                return RangeValues(
                  state.minPrice ?? 100,
                  state.maxPrice ?? 600,
                );
              },
              builder: (context, priceRange) {
                return CustomSliderPart(
                  initialRange: priceRange,
                  rangeValues: RangeValues(0, 1000),
                  onRangeChanged: (min, max) {
                    minPrice = min;
                    maxPrice = max;
                    context.read<FilterCubit>().priceRange(min, max);
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              EviraLang.of(context).sortBy,
              style: GoogleFonts.urbanist(
                color: context.textColor,
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            BlocSelector<FilterCubit, FilterState, int>(
              selector: (state) {
                return state.selectedSortIndex ?? 0;
              },
              builder: (context, selectedSortIndex) {
                return SortByBar(
                  defaultSelectedIndex: selectedSortIndex,
                  onSortSelected: (index) {
                    selectedSortIndex = index;
                    context.read<FilterCubit>().selectSort(index);
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              EviraLang.of(context).rating,
              style: GoogleFonts.urbanist(
                color: context.textColor,
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            BlocSelector<FilterCubit, FilterState, int>(
              selector: (state) {
                return state.selectedRate ?? 0;
              },
              builder: (context, selectedRate) {
                return RateBar(
                  defaultSelectedIndex: selectedRate,
                  onRateSelected: (index) {
                    selectedRatingIndex = index;
                    context.read<FilterCubit>().selectRate(index);
                  },
                  onAllSelected: () {
                    selectedRatingIndex = null;
                    context.read<FilterCubit>().selectRate(0);
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            Divider(color: context.dividerColor, thickness: 1.5),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: EviraLang.of(context).reset,
                    textColor: context.textColor,
                    backgroundColor: context.cardColor,
                    onPressed: _resetFilters,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomButton(
                    title: EviraLang.of(context).apply,
                    textColor: context.buttonTextColor,
                    backgroundColor: context.buttonColor,
                    onPressed: _applyFilters,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
