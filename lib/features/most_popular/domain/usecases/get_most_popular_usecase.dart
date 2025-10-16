import 'package:evira_e_commerce/features/most_popular/domain/entities/most_popular_entity.dart';
import 'package:evira_e_commerce/features/most_popular/domain/repos/most_popular_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMostPopularUsecase {
  final MostPopularRepo mostPopularRepo;

  GetMostPopularUsecase(this.mostPopularRepo);

  Future<List<MostPopularEntity>> call() async =>
      await mostPopularRepo.getMostPopularProducts();
}
