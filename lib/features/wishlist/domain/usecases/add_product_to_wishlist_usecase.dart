import 'package:evira_e_commerce/features/wishlist/domain/repos/wishlist_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToWishlistUsecase {
  final WishlistRepo wishlistRepo;
  AddProductToWishlistUsecase({required this.wishlistRepo});

  Future<void> call(int productId) =>
      wishlistRepo.addProductToWishlist(productId);
}
