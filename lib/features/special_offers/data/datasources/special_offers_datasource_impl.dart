import 'package:evira_e_commerce/features/special_offers/data/models/special_offers_model.dart';
import 'package:evira_e_commerce/features/special_offers/domain/datasources/special_offers_datasource.dart';
import 'package:evira_e_commerce/features/special_offers/domain/entities/special_offer_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SpecialOffersDatasource)
class SpecialOffersDatasourceImpl implements SpecialOffersDatasource {
  @override
  Future<List<SpecialOfferEntity>> getSpecialOffers() async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('special_offers')
        .select()
        .order('created_at', ascending: false);

    if (response.isEmpty) return [];

    return (response as List)
        .map((e) => SpecialOffersModel.fromJson(e).toEntity())
        .toList();
  }
}
