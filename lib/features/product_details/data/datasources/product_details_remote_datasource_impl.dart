import 'package:evira_e_commerce/features/product_details/data/models/product_details_model.dart';
import 'package:evira_e_commerce/features/product_details/domain/datasources/product_details_remote_datasource.dart';
import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ProductDetailsRemoteDatasource)
class ProductDetailsRemoteDatasourceImpl
    implements ProductDetailsRemoteDatasource {
  @override
  Future<ProductDetailsEntity?> getProductDetails(int productId) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      return null;
    }

    final response = await supabase
        .from('products')
        .select(
          '*, favorites!left(user_id), product_colors(color_name, color_hex), product_sizes(size_label)',
        )
        .eq('id', productId)
        .maybeSingle();
    // <-- returns a single map or null

    if (response == null) {
      return null;
    }

    // Convert response map to ProductDetailsModel
    final productModel = ProductDetailsModel.fromJson(response, userId);

    // Convert model to domain entity
    return productModel.toEntity();
  }
}
