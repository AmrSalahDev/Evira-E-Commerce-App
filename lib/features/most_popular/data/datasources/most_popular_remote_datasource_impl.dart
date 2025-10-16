import 'package:evira_e_commerce/features/most_popular/data/models/most_popular_model.dart';
import 'package:evira_e_commerce/features/most_popular/domain/datasources/most_popular_remote_datasource.dart';
import 'package:evira_e_commerce/features/most_popular/domain/entities/most_popular_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: MostPopularRemoteDatasource)
class MostPopularRemoteDatasourceImpl implements MostPopularRemoteDatasource {
  @override
  Future<List<MostPopularEntity>> getMostPopularProducts() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)');

    return (response as List)
        .map((json) => MostPopularModel.fromJson(json, userId).toEntity())
        .toList();
  }

  @override
  Future<List<MostPopularEntity>> getMostPopularProductsByCategory(
    int categoryId,
  ) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)')
        .eq('category_id', categoryId);

    return (response as List)
        .map((json) => MostPopularModel.fromJson(json, userId).toEntity())
        .toList();
  }
}
