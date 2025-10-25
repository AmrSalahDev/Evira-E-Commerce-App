import 'package:evira_e_commerce/features/product_details/domain/datasources/product_details_remote_datasource.dart';
import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';
import 'package:evira_e_commerce/features/product_details/domain/repos/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductDetailsRepo)
class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final ProductDetailsRemoteDatasource productDetailsRemoteDatasource;

  ProductDetailsRepoImpl(this.productDetailsRemoteDatasource);
  @override
  Future<ProductDetailsEntity?> getProductDetails(int productId) async {
    return await productDetailsRemoteDatasource.getProductDetails(productId);
  }
}
