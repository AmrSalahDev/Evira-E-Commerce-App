import 'package:evira_e_commerce/features/home/domain/datasources/home_remote_datasource.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource _remoteDatasource;

  HomeRepoImpl(this._remoteDatasource);

  @override
  Future<List<HomeProductEntity>> getProducts({
    int? categoryId,
    required int page,
    required int limit,
  }) async {
    return await _remoteDatasource.getProducts(
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
  }
}
