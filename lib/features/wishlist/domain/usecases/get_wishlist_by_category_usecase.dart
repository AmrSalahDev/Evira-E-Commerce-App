import 'package:evira_e_commerce/features/wishlist/domain/repos/wishlist_repo.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWishlistByCategoryUsecase {
  final WishlistRepo wishlistRepo;
  GetWishlistByCategoryUsecase({required this.wishlistRepo});

  Future<List<ProductEntity>> call(int categoryId) =>
      wishlistRepo.getWishlistProductsByCategory(categoryId);
}
