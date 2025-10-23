import 'package:evira_e_commerce/features/category_view/domain/datasources/category_view_remote_datasource.dart';
import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';
import 'package:evira_e_commerce/features/category_view/domain/repos/category_view_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryViewRepo)
class CategoryViewRepoImpl implements CategoryViewRepo {
  final CategoryViewRemoteDatasource remoteDataSource;

  CategoryViewRepoImpl(this.remoteDataSource);
  @override
  Future<List<CategoryViewEntity>> getCategoryProducts(int categoryId) async {
    return await remoteDataSource.getCategoryProducts(categoryId);
  }
}
