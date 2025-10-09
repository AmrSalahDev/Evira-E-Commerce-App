import 'package:evira_e_commerce/features/home/domain/entities/home_category_entity.dart';

abstract class HomeCategoryRepo {
  Future<List<HomeCategoryEntity>> getCategories(int limit);
}
