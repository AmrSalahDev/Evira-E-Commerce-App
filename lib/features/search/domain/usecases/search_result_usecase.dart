import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchResultUsecase {
  final SearchRepo searchRepo;
  SearchResultUsecase(this.searchRepo);

  Future<List<ResultProductsEntity>> call(String keyword) =>
      searchRepo.getProductsByKeyword(keyword);
}
