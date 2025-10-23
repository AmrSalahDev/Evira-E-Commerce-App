import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';
import 'package:evira_e_commerce/features/category_view/domain/repos/category_view_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryProductsUsecase {
  final CategoryViewRepo categoryViewRepo;

  GetCategoryProductsUsecase(this.categoryViewRepo);

  Future<List<CategoryViewEntity>> call(int categoryId) =>
      categoryViewRepo.getCategoryProducts(categoryId);
}
