import 'package:evira_e_commerce/shared/data/models/product_model.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_product_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeProductRepo)
class HomeProductRepoImpl implements HomeProductRepo {
  @override
  Future<List<ProductEntity>> getProductsByCategory(int categoryId) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)')
        .eq('category_id', categoryId);

    return (response as List)
        .map((json) => ProductModel.fromJson(json, userId).toEntity())
        .toList();
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    // Select all columns from the main table (*),
    // and also include related data from the favorites table,
    // joining it on the user_id column (using a LEFT JOIN).
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)');

    return (response as List)
        .map((json) => ProductModel.fromJson(json, userId).toEntity())
        .toList();
  }
}
