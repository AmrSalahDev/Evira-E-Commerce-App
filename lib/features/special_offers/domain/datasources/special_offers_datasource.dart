import 'package:evira_e_commerce/features/special_offers/domain/entities/special_offer_entity.dart';

abstract class SpecialOffersDatasource {
  Future<List<SpecialOfferEntity>> getSpecialOffers();
}
