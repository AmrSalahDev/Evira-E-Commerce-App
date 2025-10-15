import 'package:evira_e_commerce/features/wishlist/domain/repos/wishlist_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnFavoritesChangesUsecase {
  final WishlistRepo wishlistRepo;

  OnFavoritesChangesUsecase(this.wishlistRepo);

  Stream<void> call() => wishlistRepo.onFavoritesChanged();
}
