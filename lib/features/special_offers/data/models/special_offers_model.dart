import 'package:evira_e_commerce/features/special_offers/domain/entities/special_offer_entity.dart';

class SpecialOffersModel {
  final String id;
  final String title;
  final List<String> images;
  final String discount;
  final String description;

  SpecialOffersModel({
    required this.id,
    required this.title,
    required this.images,
    required this.discount,
    required this.description,
  });

  factory SpecialOffersModel.fromJson(Map<String, dynamic> json) {
    return SpecialOffersModel(
      id: json['id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      discount: json['discount'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'images': images,
      'discount': discount,
      'description': description,
    };
  }

  SpecialOfferEntity toEntity() {
    return SpecialOfferEntity(
      id: id,
      title: title,
      images: images,
      discount: discount,
      description: description,
    );
  }
}
