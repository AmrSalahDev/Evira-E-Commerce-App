import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';

abstract class SearchRepo {
  Future<void> addSearchRecentKeyword(String keyword);
  Future<void> deleteSearchRecentKeyword(int id);
  Future<void> clearAllSearchRecentKeywords();
  Future<List<SearchRecentKeywordsEntity>> getSearchRecentKeywords(
    String? keyword,
  );
  Future<List<ResultProductsEntity>> getProductsByKeyword(String keyword);
}
