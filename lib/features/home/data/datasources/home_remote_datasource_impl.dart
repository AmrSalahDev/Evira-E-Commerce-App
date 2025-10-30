import 'package:evira_e_commerce/features/home/data/models/home_product_model.dart';
import 'package:evira_e_commerce/features/home/domain/datasources/home_remote_datasource.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  @override
  Future<List<HomeProductEntity>> getProducts({
    int? categoryId,
    required int limit,
    required int page,
  }) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];

    // Calculate the start and end of the range
    final start = (page - 1) * limit;
    final end = start + limit - 1;

    final response;

    if (categoryId != null) {
      response = await supabase
          .from('products')
          .select('*, favorites!left(user_id)')
          .eq('category_id', categoryId)
          .order(
            'id',
          ) // IMPORTANT: Ordering is crucial for consistent pagination
          .range(start, end);
    } else {
      response = await supabase
          .from('products')
          .select('*, favorites!left(user_id)')
          .order(
            'id',
          ) // IMPORTANT: Ordering is crucial for consistent pagination
          .range(start, end);
    }

    print(
      'Fetched products: ${response.length}, page: $page, start: $start, end: $end',
    );

    return (response as List)
        .map((json) => HomeProductModel.fromJson(json, userId).toEntity())
        .toList();
  }
}
