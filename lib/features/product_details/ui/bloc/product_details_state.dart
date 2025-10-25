part of 'product_details_bloc.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsEntity? productDetails;
  const ProductDetailsLoaded(this.productDetails);

  @override
  List<Object> get props => [productDetails!];
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  const ProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
