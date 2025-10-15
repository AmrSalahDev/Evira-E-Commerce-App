import 'package:evira_e_commerce/features/wishlist/domain/entities/wishlist_entity.dart';

class WishlistModel extends WishlistEntity {
  WishlistModel({super.productId, super.userId, super.dateAdded, super.id});

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    productId: json['product_id'] as int,
    userId: json['user_id'] as String,
    dateAdded: DateTime.parse(json['created_at'] as String),
    id: json['id'] as int,
  );

  Map<String, dynamic> toJson(String userId) => {
    'product_id': productId,
    'user_id': userId,
    'created_at': dateAdded?.toIso8601String(),
    'id': id,
  };

  WishlistEntity toEntity() => WishlistEntity(
    productId: productId,
    userId: userId,
    dateAdded: dateAdded,
    id: id,
  );
}
