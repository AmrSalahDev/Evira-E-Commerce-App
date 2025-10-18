import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/shared/data/models/product_model.dart';

class ResultProductsModel extends ProductModel {
  const ResultProductsModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.rate,
    required super.sold,
    required super.isFavorite,
  });

  factory ResultProductsModel.fromJson(
    Map<String, dynamic> json,
    String userId,
  ) {
    final favorites = json['favorites'] as List?;
    final isFavorite =
        favorites != null && favorites.any((f) => f['user_id'] == userId);
    return ResultProductsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      sold: json['sold'] ?? 0,
      isFavorite: isFavorite,
    );
  }

  @override
  ResultProductsEntity toEntity() {
    return ResultProductsEntity(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      rate: rate,
      sold: sold,
      isFavorite: isFavorite,
    );
  }
}
