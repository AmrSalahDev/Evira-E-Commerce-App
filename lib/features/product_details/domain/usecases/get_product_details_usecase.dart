import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';
import 'package:evira_e_commerce/features/product_details/domain/repos/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductDetailsUsecase {
  final ProductDetailsRepo productDetailsRepo;

  GetProductDetailsUsecase(this.productDetailsRepo);

  Future<ProductDetailsEntity?> call(int productId) =>
      productDetailsRepo.getProductDetails(productId);
}
