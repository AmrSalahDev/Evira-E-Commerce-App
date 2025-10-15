import 'package:evira_e_commerce/features/home/data/models/home_banner_model.dart';
import 'package:evira_e_commerce/shared/domain/entities/banner_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_banner_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeBannerRepo)
class HomeBannerRepoImpl extends HomeBannerRepo {
  @override
  Future<List<BannerEntity>> getBanners(int limit) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('home_banners').select().limit(limit);

    return (response as List)
        .map((e) => HomeBannerModel.fromJson(e).toEntity())
        .toList();
  }
}
