part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final int productId;
  const GetProductDetailsEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
