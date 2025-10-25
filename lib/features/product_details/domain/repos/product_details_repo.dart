import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRepo {
  Future<ProductDetailsEntity?> getProductDetails(int productId);
}
