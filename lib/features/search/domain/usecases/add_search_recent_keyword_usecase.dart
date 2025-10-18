import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddSearchRecentKeywordUsecase {
  final SearchRepo searchRepo;

  AddSearchRecentKeywordUsecase(this.searchRepo);

  Future<void> call(String keyword) =>
      searchRepo.addSearchRecentKeyword(keyword);
}
