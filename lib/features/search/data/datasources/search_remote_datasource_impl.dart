import 'package:evira_e_commerce/features/search/data/models/result_products_model.dart';
import 'package:evira_e_commerce/features/search/data/models/search_recent_keywords_model.dart';
import 'package:evira_e_commerce/features/search/domain/datasources/search_remote_datasource.dart';
import 'package:evira_e_commerce/features/search/domain/entities/filter_entity.dart';
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
          .limit(20);
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

  @override
  Future<List<ResultProductsEntity>> applyFilters({
    required FilterEntity filter,
    required String keyword,
  }) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final trimmed = keyword.trim();
    if (trimmed.isEmpty) return [];

    // Use dynamic to avoid static typing mismatch between builder classes
    dynamic query = supabase
        .from('products')
        .select('*, favorites!left(user_id)');

    // Try to find category by keyword (maybeSingle returns null if not found)
    final categoryResult = await supabase
        .from('categories')
        .select()
        .ilike('name', '%$trimmed%')
        .limit(1)
        .maybeSingle();

    if (categoryResult != null) {
      // If keyword is a category name → search by that category_id
      query = query.eq('category_id', categoryResult['id']);
    } else {
      // Otherwise search by product name
      query = query.ilike('name', '%$trimmed%');
    }

    // Apply selected category filter (if user manually chose one)
    if (filter.categoryId != null) {
      query = query.eq('category_id', filter.categoryId);
    }

    // Apply price range filter
    query = query.gte('price', filter.minPrice).lte('price', filter.maxPrice);

    // Apply rating filter (e.g. rating 3 → show products with rate >= 3)
    if (filter.ratingIndex != null) {
      query = query.gte('rate', filter.ratingIndex!);
    }

    // Apply sorting based on SortByBar index
    if (filter.sortIndex != null) {
      switch (filter.sortIndex) {
        case 0: // Popular
          query = query.order('popularity', ascending: false);
          break;
        case 1: // Most Recent
          query = query.order('created_at', ascending: false);
          break;
        case 2: // Price High
          query = query.order('price', ascending: false);
          break;
        case 3: // Price Low
          query = query.order('price', ascending: true);
          break;
        case 4: // Most Rated
          query = query.order('rate', ascending: false);
          break;
        case 5: // Best Selling
          query = query.order('sold', ascending: false);
          break;
        default:
          query = query.order('created_at', ascending: false);
      }
    } else {
      query = query.order('created_at', ascending: false);
    }

    // Execute final query
    final response = await query;

    if (response == null) return [];

    // Convert to entity list (response is expected to be a List<Map<String, dynamic>>)
    final List mapList = response as List;
    return mapList
        .map(
          (e) => ResultProductsModel.fromJson(
            e as Map<String, dynamic>,
            userId,
          ).toEntity(),
        )
        .toList();
  }
}
