import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';

abstract class SearchRemoteDatasource {
  Future<List<SearchRecentKeywordsEntity>> getSearchRecentKeywords(
    String? keyword,
  );
  Future<void> addSearchRecentKeyword(String keyword);
  Future<void> deleteSearchRecentKeyword(int id);
  Future<void> clearAllSearchRecentKeywords();
  Future<List<ResultProductsEntity>> getProductsByKeyword(String keyword);
}
