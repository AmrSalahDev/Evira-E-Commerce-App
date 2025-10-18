import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteRecentKeywordUsecase {
  final SearchRepo searchRepo;

  DeleteRecentKeywordUsecase(this.searchRepo);

  Future<void> call(int id) => searchRepo.deleteSearchRecentKeyword(id);
}
