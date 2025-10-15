import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final double rate;
  final int sold;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rate,
    required this.sold,
    required this.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String userId) {
    final favorites = json['favorites'] as List?;
    final isFavorite =
        favorites != null && favorites.any((f) => f['user_id'] == userId);

    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      sold: json['sold'] ?? 0,
      isFavorite: isFavorite,
    );
  }

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    String? imageUrl,
    double? rate,
    int? sold,
    bool? isFavorite,
  }) => ProductModel(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    imageUrl: imageUrl ?? this.imageUrl,
    rate: rate ?? this.rate,
    sold: sold ?? this.sold,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  Map<String, dynamic> toJson(String userId) => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'price': price,
    'rate': rate,
    'sold': sold,
    'isFavorite': isFavorite,
    'favorites': isFavorite
        ? [
            {'user_id': userId},
          ]
        : [],
  };

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    imageUrl,
    rate,
    sold,
    isFavorite,
  ];

  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    price: price,
    imageUrl: imageUrl,
    rate: rate,
    sold: sold,
    isFavorite: isFavorite,
  );
}
