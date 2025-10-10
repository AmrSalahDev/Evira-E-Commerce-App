part of 'home_product_cubit.dart';

sealed class HomeProductState extends Equatable {
  const HomeProductState();
  @override
  List<Object?> get props => [];
}

class HomeProductInitial extends HomeProductState {}

class HomeProductLoading extends HomeProductState {}

class HomeProductLoaded extends HomeProductState {
  final List<HomeProductEntity> products;
  const HomeProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class HomeProductError extends HomeProductState {
  final String message;
  const HomeProductError(this.message);

  @override
  List<Object?> get props => [message];
}
