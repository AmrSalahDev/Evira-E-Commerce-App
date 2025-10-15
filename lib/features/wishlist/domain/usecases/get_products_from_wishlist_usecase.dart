import 'package:evira_e_commerce/features/wishlist/domain/repos/wishlist_repo.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsFromWishlistUsecase {
  final WishlistRepo wishlistRepo;

  GetProductsFromWishlistUsecase(this.wishlistRepo);

  Future<List<ProductEntity>> call() => wishlistRepo.getWishlistProducts();
}
