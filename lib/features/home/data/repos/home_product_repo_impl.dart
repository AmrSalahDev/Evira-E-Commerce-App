import 'package:evira_e_commerce/features/home/data/models/home_product_model.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_product_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeProductRepo)
class HomeProductRepoImpl implements HomeProductRepo {
  @override
  Future<List<HomeProductEntity>> getProductsByCategory(
    int categoryId,
    String userId,
  ) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)')
        .eq('category_id', categoryId);

    return (response as List)
        .map((json) => HomeProductModel.fromJson(json, userId).toEntity())
        .toList();
  }

  @override
  Future<void> toggleFavorite(
    int productId,
    String userId,
    bool isFavorite,
  ) async {
    final supabase = Supabase.instance.client;
    if (isFavorite) {
      await supabase.from('favorites').delete().match({
        'user_id': userId,
        'product_id': productId,
      });
    } else {
      await supabase.from('favorites').insert({
        'user_id': userId,
        'product_id': productId,
      });
    }
  }

  @override
  Future<List<HomeProductEntity>> getAllProducts(String userId) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('products')
        .select('*, favorites!left(user_id)');

    return (response as List)
        .map((json) => HomeProductModel.fromJson(json, userId).toEntity())
        .toList();
  }
}
