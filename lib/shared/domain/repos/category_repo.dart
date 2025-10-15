import 'package:evira_e_commerce/shared/domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Future<List<CategoryEntity>> getCategories(int limit);
}
