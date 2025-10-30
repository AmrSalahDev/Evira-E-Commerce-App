import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeProductsUsecase {
  final HomeRepo homeRepo;
  GetHomeProductsUsecase(this.homeRepo);

  Future<List<HomeProductEntity>> call({
    int? categoryId,
    required int limit,
    required int page,
  }) async => await homeRepo.getProducts(
    page: page,
    limit: limit,
    categoryId: categoryId,
  );
}
