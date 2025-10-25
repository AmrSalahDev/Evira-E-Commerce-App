import 'package:evira_e_commerce/features/product_details/data/models/product_color_model.dart';
import 'package:evira_e_commerce/features/product_details/data/models/product_size_model.dart';
import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';
import 'package:evira_e_commerce/shared/data/models/product_model.dart';

class ProductDetailsModel extends ProductModel {
  final String decsription;
  final List<ProductColorModel> colors;
  final List<ProductSizeModel> sizes;
  const ProductDetailsModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.rate,
    required super.sold,
    required super.isFavorite,
    required this.decsription,
    required this.colors,
    required this.sizes,
  });

  factory ProductDetailsModel.fromJson(
    Map<String, dynamic> json,
    String userId,
  ) {
    final favorites = json['favorites'] as List?;
    final isFavorite =
        favorites != null && favorites.any((f) => f['user_id'] == userId);
    final colorsJson = json['product_colors'] as List? ?? [];
    final sizesJson = json['product_sizes'] as List? ?? [];
    return ProductDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      sold: json['sold'] ?? 0,
      decsription: json['description'] ?? '',
      isFavorite: isFavorite,
      sizes: sizesJson.map((s) => ProductSizeModel.fromJson(s)).toList(),
      colors: colorsJson
          .map((color) => ProductColorModel.fromJson(color))
          .toList(),
    );
  }

  @override
  ProductDetailsEntity toEntity() => ProductDetailsEntity(
    id: id,
    name: name,
    price: price,
    imageUrl: imageUrl,
    rate: rate,
    sold: sold,
    isFavorite: isFavorite,
    description: decsription,
    colors: colors.map((c) => c.toEntity()).toList(),
    sizes: sizes.map((s) => s.toEntity()).toList(),
  );
}
