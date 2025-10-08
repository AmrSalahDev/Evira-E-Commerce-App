import 'package:evira_e_commerce/features/home/domain/entities/home_banner_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_banner_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeBannersUseCase {
  final HomeBannerRepo repo;

  GetHomeBannersUseCase(this.repo);

  Future<List<HomeBannerEntity>> call(int limit) {
    return repo.getBanners(limit);
  }
}
