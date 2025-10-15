import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsByCategoryIdUsecase {
  final HomeProductRepo homeProductRepo;

  GetProductsByCategoryIdUsecase(this.homeProductRepo);

  Future<List<ProductEntity>> call(int categoryId) async =>
      await homeProductRepo.getProductsByCategory(categoryId);
}
