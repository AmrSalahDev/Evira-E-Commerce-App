import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';

abstract class HomeProductRepo {
  Future<List<ProductEntity>> getProductsByCategory({
    required int page,
    required int limit,
    required int categoryId,
  });

  Future<List<ProductEntity>> getAllProducts({
    required int page,
    required int limit,
  });
}
