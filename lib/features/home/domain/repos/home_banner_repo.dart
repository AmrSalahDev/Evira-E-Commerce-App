import 'package:evira_e_commerce/features/home/domain/entities/home_banner_entity.dart';

abstract class HomeBannerRepo {
  Future<List<HomeBannerEntity>> getBanners(int limit);
}
