import 'package:evira_e_commerce/features/category_view/data/models/category_view_model.dart';
import 'package:evira_e_commerce/features/category_view/domain/datasources/category_view_remote_datasource.dart';
import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: CategoryViewRemoteDatasource)
class CategoryViewRemoteDatasourceImpl implements CategoryViewRemoteDatasource {
  @override
  Future<List<CategoryViewEntity>> getCategoryProducts(int categoryId) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)')
        .eq('category_id', categoryId);

    return (response as List)
        .map((json) => CategoryViewModel.fromJson(json, userId).toEntity())
        .toList();
  }
}
