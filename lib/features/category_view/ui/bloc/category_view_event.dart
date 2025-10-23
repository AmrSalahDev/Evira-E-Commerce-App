part of 'category_view_bloc.dart';

sealed class CategoryViewEvent extends Equatable {
  const CategoryViewEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryProductsEvent extends CategoryViewEvent {
  final int categoryId;
  const GetCategoryProductsEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
