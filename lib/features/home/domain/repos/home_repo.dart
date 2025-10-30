import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';

abstract class HomeRepo {
  Future<List<HomeProductEntity>> getProducts({
    int? categoryId,
    required int page,
    required int limit,
  });
}
