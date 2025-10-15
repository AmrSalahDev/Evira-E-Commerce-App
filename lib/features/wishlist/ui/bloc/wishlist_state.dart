part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final List<ProductEntity> wishlistProducts;
  const WishlistLoaded({required this.wishlistProducts});

  @override
  List<Object> get props => [wishlistProducts];
}

final class WishlistError extends WishlistState {
  final String message;
  const WishlistError({required this.message});

  @override
  List<Object> get props => [message];
}
