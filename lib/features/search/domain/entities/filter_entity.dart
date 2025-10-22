class FilterEntity {
  final int? categoryId;
  final double minPrice;
  final double maxPrice;
  final int? sortIndex;
  final int? ratingIndex;

  const FilterEntity({
    this.categoryId,
    this.minPrice = 0,
    this.maxPrice = 1000,
    this.sortIndex,
    this.ratingIndex,
  });

  FilterEntity copyWith({
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int? sortIndex,
    int? ratingIndex,
  }) {
    return FilterEntity(
      categoryId: categoryId ?? this.categoryId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortIndex: sortIndex ?? this.sortIndex,
      ratingIndex: ratingIndex ?? this.ratingIndex,
    );
  }
}
