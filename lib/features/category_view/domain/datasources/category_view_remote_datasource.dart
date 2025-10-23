import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';

abstract class CategoryViewRemoteDatasource {
  Future<List<CategoryViewEntity>> getCategoryProducts(int categoryId);
}
