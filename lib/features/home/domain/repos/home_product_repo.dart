import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';

abstract class HomeProductRepo {
  Future<List<ProductEntity>> getProductsByCategory(int categoryId);

  Future<List<ProductEntity>> getAllProducts();
}
