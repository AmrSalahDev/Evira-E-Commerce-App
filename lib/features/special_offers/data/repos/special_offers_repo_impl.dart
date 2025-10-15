import 'package:evira_e_commerce/features/special_offers/domain/datasources/special_offers_datasource.dart';
import 'package:evira_e_commerce/features/special_offers/domain/entities/special_offer_entity.dart';
import 'package:evira_e_commerce/features/special_offers/domain/repos/specail_offers_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SpecialOffersRepo)
class SpecialOffersRepoImpl implements SpecialOffersRepo {
  final SpecialOffersDatasource specialOffersDatasource;

  SpecialOffersRepoImpl(this.specialOffersDatasource);
  @override
  Future<List<SpecialOfferEntity>> getSpecialOffers() async {
    return await specialOffersDatasource.getSpecialOffers();
  }
}
