import 'package:evira_e_commerce/features/search/domain/datasources/search_remote_datasource.dart';
import 'package:evira_e_commerce/features/search/domain/entities/filter_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDatasource searchRemoteDataSource;

  SearchRepoImpl(this.searchRemoteDataSource);
  @override
  Future<void> addSearchRecentKeyword(String keyword) async {
    await searchRemoteDataSource.addSearchRecentKeyword(keyword);
  }

  @override
  Future<void> clearAllSearchRecentKeywords() async {
    await searchRemoteDataSource.clearAllSearchRecentKeywords();
  }

  @override
  Future<void> deleteSearchRecentKeyword(int id) async {
    await searchRemoteDataSource.deleteSearchRecentKeyword(id);
  }

  @override
  Future<List<SearchRecentKeywordsEntity>> getSearchRecentKeywords(
    String? keyword,
  ) async {
    return await searchRemoteDataSource.getSearchRecentKeywords(keyword);
  }

  @override
  Future<List<ResultProductsEntity>> getProductsByKeyword(
    String keyword,
  ) async {
    return await searchRemoteDataSource.getProductsByKeyword(keyword);
  }

  @override
  Future<List<ResultProductsEntity>> applyFilters({
    required FilterEntity filter,
    required String keyword,
  }) async {
    return await searchRemoteDataSource.applyFilters(
      filter: filter,
      keyword: keyword,
    );
  }
}
