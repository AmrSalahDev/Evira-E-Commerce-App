import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';

class HomeProductEntity extends ProductEntity {
  HomeProductEntity({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.price,
    required super.rate,
    required super.sold,
    required super.isFavorite,
  });
}
