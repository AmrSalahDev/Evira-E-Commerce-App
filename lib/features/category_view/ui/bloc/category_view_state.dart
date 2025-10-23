part of 'category_view_bloc.dart';

sealed class CategoryViewState extends Equatable {
  const CategoryViewState();

  @override
  List<Object> get props => [];
}

final class CategoryViewInitial extends CategoryViewState {}

final class CategoryViewLoading extends CategoryViewState {}

final class CategoryViewLoaded extends CategoryViewState {
  final List<CategoryViewEntity> categoryProducts;
  const CategoryViewLoaded(this.categoryProducts);
}

final class CategoryViewError extends CategoryViewState {
  final String message;
  const CategoryViewError(this.message);

  @override
  List<Object> get props => [message];
}
