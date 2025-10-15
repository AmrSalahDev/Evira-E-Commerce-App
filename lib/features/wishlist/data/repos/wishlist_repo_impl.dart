import 'package:evira_e_commerce/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:evira_e_commerce/features/wishlist/domain/repos/wishlist_repo.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WishlistRepo)
class WishlistRepoImpl implements WishlistRepo {
  final WishlistRemoteDataSource wishlistRemoteDataSource;

  WishlistRepoImpl(this.wishlistRemoteDataSource);

  @override
  Future<void> addProductToWishlist(int productId) async {
    await wishlistRemoteDataSource.addProductToWishlist(productId);
  }

  @override
  Future<List<ProductEntity>> getWishlistProducts() async {
    return await wishlistRemoteDataSource.getWishlistProducts();
  }

  @override
  Future<bool> isProductInWishlist(int productId) async {
    return await wishlistRemoteDataSource.isProductInWishlist(productId);
  }

  @override
  Future<void> removeProductFromWishlist(int productId) async {
    await wishlistRemoteDataSource.removeProductFromWishlist(productId);
  }

  @override
  Future<void> toggleFavorite(int productId, bool isFavorite) async {
    await wishlistRemoteDataSource.toggleFavorite(productId, isFavorite);
  }

  @override
  Future<List<ProductEntity>> getWishlistProductsByCategory(
    int categoryId,
  ) async {
    return await wishlistRemoteDataSource.getWishlistProductsByCategory(
      categoryId,
    );
  }

  @override
  Stream<void> onFavoritesChanged() {
    return wishlistRemoteDataSource.onFavoritesChanged();
  }
}
