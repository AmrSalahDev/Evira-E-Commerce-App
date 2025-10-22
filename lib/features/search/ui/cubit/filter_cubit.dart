import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilterCubit extends HydratedCubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void selectRate(int rate) => emit(state.copyWith(selectedRate: rate));
  void selectSort(int index) => emit(state.copyWith(selectedSortIndex: index));
  void selectCategory(int index) =>
      emit(state.copyWith(selectedCategoryIndex: index));
  void priceRange(double min, double max) {
    emit(state.copyWith(minPrice: min, maxPrice: max));
  }

  void clearFilters() => emit(const FilterState());

  @override
  FilterState? fromJson(Map<String, dynamic> json) {
    return FilterState(
      selectedRate: json['selectedRate'] as int?,
      selectedSortIndex: json['selectedSortIndex'] as int?,
      selectedCategoryIndex: json['selectedCategoryIndex'] as int?,
      minPrice: json['minPrice'] as double?,
      maxPrice: json['maxPrice'] as double?,
    );
  }

  @override
  Map<String, dynamic>? toJson(FilterState state) {
    return {
      'selectedRate': state.selectedRate,
      'selectedSortIndex': state.selectedSortIndex,
      'selectedCategoryIndex': state.selectedCategoryIndex,
      'minPrice': state.minPrice,
      'maxPrice': state.maxPrice,
    };
  }
}

class FilterState {
  final int? selectedRate;
  final int? selectedSortIndex;
  final int? selectedCategoryIndex;
  final double? minPrice;
  final double? maxPrice;

  const FilterState({
    this.selectedRate,
    this.selectedSortIndex,
    this.selectedCategoryIndex,
    this.minPrice,
    this.maxPrice,
  });

  FilterState copyWith({
    int? selectedRate,
    int? selectedSortIndex,
    int? selectedCategoryIndex,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterState(
      selectedRate: selectedRate ?? this.selectedRate,
      selectedSortIndex: selectedSortIndex ?? this.selectedSortIndex,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}
