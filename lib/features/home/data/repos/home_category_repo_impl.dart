import 'package:evira_e_commerce/features/home/data/models/home_category_model.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_category_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_category_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeCategoryRepo)
class HomeCategoryRepoImpl extends HomeCategoryRepo {
  @override
  Future<List<HomeCategoryEntity>> getCategories(int limit) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('home_categories')
        .select()
        .limit(limit);

    return (response as List)
        .map((e) => HomeCategoryModel.fromJson(e).toEntity())
        .toList();
  }
}
