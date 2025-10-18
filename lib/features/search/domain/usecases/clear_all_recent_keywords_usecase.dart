import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearAllRecentKeywordsUsecase {
  final SearchRepo searchRepo;

  ClearAllRecentKeywordsUsecase(this.searchRepo);

  Future<void> call() => searchRepo.clearAllSearchRecentKeywords();
}
