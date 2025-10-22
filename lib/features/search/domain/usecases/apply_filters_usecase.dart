import 'package:evira_e_commerce/features/search/domain/entities/filter_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyFiltersUsecase {
  final SearchRepo searchRepo;
  ApplyFiltersUsecase(this.searchRepo);
  Future<List<ResultProductsEntity>> call(
    FilterEntity filter,
    String keyword,
  ) => searchRepo.applyFilters(filter: filter, keyword: keyword);
}
