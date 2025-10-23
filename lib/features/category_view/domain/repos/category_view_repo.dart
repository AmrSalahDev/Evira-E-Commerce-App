import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';

abstract class CategoryViewRepo {
  Future<List<CategoryViewEntity>> getCategoryProducts(int categoryId);
}
