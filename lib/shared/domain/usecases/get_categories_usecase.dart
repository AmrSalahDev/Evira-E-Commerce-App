import 'package:evira_e_commerce/shared/domain/entities/category_entity.dart';
import 'package:evira_e_commerce/shared/domain/repos/category_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final CategoryRepo repo;

  GetCategoriesUseCase(this.repo);

  Future<List<CategoryEntity>> call(int limit) {
    return repo.getCategories(limit);
  }
}
