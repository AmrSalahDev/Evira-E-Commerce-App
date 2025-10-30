import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';

abstract class HomeRemoteDatasource {
  Future<List<HomeProductEntity>> getProducts({
    int? categoryId,
    required int limit,
    required int page,
  });
}
