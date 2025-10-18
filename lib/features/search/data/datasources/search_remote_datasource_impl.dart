import 'package:evira_e_commerce/features/search/data/models/result_products_model.dart';
import 'package:evira_e_commerce/features/search/data/models/search_recent_keywords_model.dart';
import 'package:evira_e_commerce/features/search/domain/datasources/search_remote_datasource.dart';
import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SearchRemoteDatasource)
class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  final supabase = Supabase.instance.client;
  static const tableName = 'recent_keywords';

  @override
  Future<void> addSearchRecentKeyword(String keyword) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null || keyword.trim().isEmpty) return;

    // Upsert ensures: if keyword already exists for this user, just update timestamp
    await supabase.from(tableName).upsert({
      'user_id': userId,
      'keyword': keyword.trim(),
      'created_at': DateTime.now().toIso8601String(),
    });

    // Optional: keep only last 10 keywords per user
    // await supabase.rpc(
    //   'limit_recent_keywords',
    //   params: {'user_id_param': userId},
    // );
  }

  @override
  Future<void> clearAllSearchRecentKeywords() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase.from(tableName).delete().eq('user_id', userId);
  }

  @override
  Future<void> deleteSearchRecentKeyword(int id) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase
        .from(tableName)
        .delete()
        .eq('id', id)
        .eq('user_id', userId); // extra safety to delete only user's own entry
  }

  @override
  Future<List<SearchRecentKeywordsEntity>> getSearchRecentKeywords(
    String? keyword,
  ) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];

    dynamic query;

    if (keyword != null && keyword.trim().isNotEmpty) {
      query = await supabase
          .from(tableName)
          .select()
          .eq('user_id', userId)
          .ilike('keyword', '%$keyword%')
          .order('created_at', ascending: false)
          .limit(10);
    } else {
      query = await supabase
          .from(tableName)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(10);
    }

    final response = await query;

    if (response is! List) return [];

    return response
        .map((e) => SearchRecentKeywordsModel.fromJson(e).toEntity())
        .toList();
  }

  @override
  Future<List<ResultProductsEntity>> getProductsByKeyword(
    String keyword,
  ) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];
    final trimmed = keyword.trim();
    if (trimmed.isEmpty) return [];

    // Try to find a category
    final categories = await supabase
        .from('categories')
        .select()
        .ilike('name', '%$trimmed%')
        .limit(1);

    final category = categories.isNotEmpty ? categories.first : null;

    if (category != null) {
      // Found a category → return its products
      final products = await supabase
          .from('products')
          .select('*, favorites!left(user_id)')
          .eq('category_id', category['id']);

      return products
          .map((e) => ResultProductsModel.fromJson(e, userId).toEntity())
          .toList();
    }

    // Otherwise, search by product name
    final products = await supabase
        .from('products')
        .select('*, favorites!left(user_id)')
        .ilike('name', '%$trimmed%');
    return products
        .map((e) => ResultProductsModel.fromJson(e, userId).toEntity())
        .toList();
  }
}
