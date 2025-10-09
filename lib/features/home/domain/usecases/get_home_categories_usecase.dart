import 'package:evira_e_commerce/features/home/domain/entities/home_category_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_category_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeCategoriesUseCase {
  final HomeCategoryRepo repo;

  GetHomeCategoriesUseCase(this.repo);

  Future<List<HomeCategoryEntity>> call(int limit) {
    return repo.getCategories(limit);
  }
}
