part of 'home_products_bloc.dart';

abstract class HomeProductsEvent extends Equatable {
  const HomeProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeProducts extends HomeProductsEvent {
  final int? categoryId;
  final int limit;
  final int page;

  const LoadHomeProducts({
    this.categoryId,
    required this.limit,
    required this.page,
  });

  @override
  List<Object?> get props => [categoryId, limit, page];
}

class LoadMoreHomeProducts extends HomeProductsEvent {
  final int? categoryId;
  final int limit;
  final int page;

  const LoadMoreHomeProducts({
    this.categoryId,
    required this.limit,
    required this.page,
  });

  @override
  List<Object?> get props => [categoryId, limit, page];
}
