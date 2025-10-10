import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';

class HomeProductModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final double rate;
  final int sold;
  final bool isFavorite;

  const HomeProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rate,
    required this.sold,
    required this.isFavorite,
  });

  factory HomeProductModel.fromJson(Map<String, dynamic> json, String userId) {
    final favorites = json['favorites'] as List?;
    final isFavorite =
        favorites != null && favorites.any((f) => f['user_id'] == userId);

    return HomeProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'].toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? '',
      rate: json['rate'].toDouble() ?? 0.0,
      sold: json['sold'] ?? 0,
      isFavorite: isFavorite,
    );
  }

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

  HomeProductEntity toEntity() => HomeProductEntity(
    id: id,
    name: name,
    price: price,
    imageUrl: imageUrl,
    rate: rate,
    sold: sold,
    isFavorite: isFavorite,
  );
}
