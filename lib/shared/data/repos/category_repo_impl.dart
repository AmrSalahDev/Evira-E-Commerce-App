import 'package:evira_e_commerce/shared/data/models/category_model.dart';
import 'package:evira_e_commerce/shared/domain/entities/category_entity.dart';
import 'package:evira_e_commerce/shared/domain/repos/category_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: CategoryRepo)
class CategoryRepoImpl extends CategoryRepo {
  @override
  Future<List<CategoryEntity>> getCategories(int limit) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('categories').select().limit(limit);

    return (response as List)
        .map((e) => CategoryModel.fromJson(e).toEntity())
        .toList();
  }
}
