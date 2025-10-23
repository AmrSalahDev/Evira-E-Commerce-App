import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';
import 'package:evira_e_commerce/shared/data/models/product_model.dart';

class CategoryViewModel extends ProductModel {
  const CategoryViewModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.rate,
    required super.sold,
    required super.isFavorite,
  });

  factory CategoryViewModel.fromJson(Map<String, dynamic> json, String userId) {
    final favorites = json['favorites'] as List?;
    final isFavorite =
        favorites != null && favorites.any((f) => f['user_id'] == userId);
    return CategoryViewModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      rate: json['rate'],
      sold: json['sold'],
      isFavorite: isFavorite,
    );
  }

  @override
  CategoryViewEntity toEntity() => CategoryViewEntity(
    id: id,
    name: name,
    price: price,
    imageUrl: imageUrl,
    rate: rate,
    sold: sold,
    isFavorite: isFavorite,
  );
}
