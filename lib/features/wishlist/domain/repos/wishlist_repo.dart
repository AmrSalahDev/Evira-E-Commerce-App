import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';

abstract class WishlistRepo {
  Future<List<ProductEntity>> getWishlistProducts();
  Future<List<ProductEntity>> getWishlistProductsByCategory(int categoryId);
  Future<void> addProductToWishlist(int productId);
  Future<void> removeProductFromWishlist(int productId);
  Future<bool> isProductInWishlist(int productId);
  Future<void> toggleFavorite(int productId, bool isFavorite);
  Stream<void> onFavoritesChanged();
}
