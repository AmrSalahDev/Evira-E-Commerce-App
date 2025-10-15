import 'package:evira_e_commerce/features/special_offers/domain/entities/special_offer_entity.dart';
import 'package:evira_e_commerce/features/special_offers/domain/repos/specail_offers_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSpecialOffersUsecase {
  final SpecialOffersRepo specialOffersRepo;

  GetSpecialOffersUsecase({required this.specialOffersRepo});

  Future<List<SpecialOfferEntity>> call() =>
      specialOffersRepo.getSpecialOffers();
}
