import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';

abstract class HomeProductRepo {
  Future<List<HomeProductEntity>> getProductsByCategory(
    int categoryId,
    String userId,
  );
  Future<void> toggleFavorite(int productId, String userId, bool isFavorite);

  Future<List<HomeProductEntity>> getAllProducts(String userId);
}
