import 'package:evira_e_commerce/shared/domain/entities/banner_entity.dart';

abstract class HomeBannerRepo {
  Future<List<BannerEntity>> getBanners(int limit);
}
