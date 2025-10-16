import 'package:evira_e_commerce/features/most_popular/domain/entities/most_popular_entity.dart';

abstract class MostPopularRemoteDatasource {
  Future<List<MostPopularEntity>> getMostPopularProducts();
  Future<List<MostPopularEntity>> getMostPopularProductsByCategory(
    int categoryId,
  );
}
