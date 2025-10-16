import 'package:evira_e_commerce/features/most_popular/domain/entities/most_popular_entity.dart';
import 'package:evira_e_commerce/shared/data/models/product_model.dart';

class MostPopularModel extends ProductModel {
  const MostPopularModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.rate,
    required super.sold,
    required super.isFavorite,
  });

  factory MostPopularModel.fromJson(Map<String, dynamic> json, String userId) {
    final favorites = json['favorites'] as List?;
    final isFavorite =
        favorites != null && favorites.any((f) => f['user_id'] == userId);

    return MostPopularModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      sold: json['sold'] ?? 0,
      isFavorite: isFavorite,
    );
  }

  @override
  MostPopularEntity toEntity() => MostPopularEntity(
    id: id,
    name: name,
    price: price,
    imageUrl: imageUrl,
    rate: rate,
    sold: sold,
    isFavorite: isFavorite,
  );
}
