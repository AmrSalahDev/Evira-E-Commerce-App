part of 'home_category_cubit.dart';

sealed class HomeCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeCategoryInitial extends HomeCategoryState {}

class HomeCategoryLoading extends HomeCategoryState {}

class HomeCategoryLoaded extends HomeCategoryState {
  final List<HomeCategoryEntity> categories;
  HomeCategoryLoaded(this.categories);
}

class HomeCategoryError extends HomeCategoryState {
  final String message;
  HomeCategoryError(this.message);
}
