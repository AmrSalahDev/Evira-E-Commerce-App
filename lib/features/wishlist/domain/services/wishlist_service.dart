import 'package:evira_e_commerce/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WishlistService {
  final WishlistRemoteDataSource wishlistRemoteDataSource;

  WishlistService(this.wishlistRemoteDataSource);
  Future<void> addProductToWishlist(int productId) async {
    await wishlistRemoteDataSource.addProductToWishlist(productId);
  }

  Future<void> removeProductFromWishlist(int productId) async {
    await wishlistRemoteDataSource.removeProductFromWishlist(productId);
  }

  Future<bool> isProductInWishlist(int productId) async {
    return await wishlistRemoteDataSource.isProductInWishlist(productId);
  }

  Future<void> toggleFavorite(int productId, bool isFavorite) async {
    await wishlistRemoteDataSource.toggleFavorite(productId, isFavorite);
  }
}
