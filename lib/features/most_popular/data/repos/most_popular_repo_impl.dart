import 'package:evira_e_commerce/features/most_popular/domain/datasources/most_popular_remote_datasource.dart';
import 'package:evira_e_commerce/features/most_popular/domain/entities/most_popular_entity.dart';
import 'package:evira_e_commerce/features/most_popular/domain/repos/most_popular_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MostPopularRepo)
class MostPopularRepoImpl implements MostPopularRepo {
  final MostPopularRemoteDatasource mostPopularRemoteDatasource;

  MostPopularRepoImpl(this.mostPopularRemoteDatasource);
  @override
  Future<List<MostPopularEntity>> getMostPopularProducts() async {
    return await mostPopularRemoteDatasource.getMostPopularProducts();
  }

  @override
  Future<List<MostPopularEntity>> getMostPopularProductsByCategory(
    int categoryId,
  ) {
    return mostPopularRemoteDatasource.getMostPopularProductsByCategory(
      categoryId,
    );
  }
}
