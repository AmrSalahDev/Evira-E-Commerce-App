part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class AddProductToWishlist extends WishlistEvent {
  final int productId;
  const AddProductToWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}

class RemoveProductFromWishlist extends WishlistEvent {
  final int productId;
  const RemoveProductFromWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}

class GetProductsFromWishlist extends WishlistEvent {}

class GetProductsFromWishlistByCategory extends WishlistEvent {
  final int categoryId;
  const GetProductsFromWishlistByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class OnFavoritesChanges extends WishlistEvent {
  final int categoryId;
  const OnFavoritesChanges(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
