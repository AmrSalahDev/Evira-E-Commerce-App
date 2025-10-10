import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsByCategoryIdUsecase {
  final HomeProductRepo homeProductRepo;

  GetProductsByCategoryIdUsecase(this.homeProductRepo);

  Future<List<HomeProductEntity>> call(int categoryId, String userId) async =>
      await homeProductRepo.getProductsByCategory(categoryId, userId);
}
