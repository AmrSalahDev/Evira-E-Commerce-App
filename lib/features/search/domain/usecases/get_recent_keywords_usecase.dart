import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecentKeywordsUsecase {
  final SearchRepo searchRepo;
  GetRecentKeywordsUsecase(this.searchRepo);

  Future<List<SearchRecentKeywordsEntity>> call(String? keyword) =>
      searchRepo.getSearchRecentKeywords(keyword);
}
