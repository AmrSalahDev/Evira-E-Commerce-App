part of 'home_products_bloc.dart';

sealed class HomeProductsState extends Equatable {
  const HomeProductsState();

  @override
  List<Object> get props => [];
}

final class HomeProductsInitial extends HomeProductsState {}

final class HomeProductsLoading extends HomeProductsState {}

final class HomeProductsLoaded extends HomeProductsState {
  final List<HomeProductEntity> products;
  final bool hasReachedEnd;
  const HomeProductsLoaded({
    required this.products,
    required this.hasReachedEnd,
  });

  @override
  List<Object> get props => [products, hasReachedEnd];
}

final class HomeProductsError extends HomeProductsState {
  final String message;
  const HomeProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
