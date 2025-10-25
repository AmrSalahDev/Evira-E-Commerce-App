import 'package:evira_e_commerce/features/product_details/domain/entities/product_color_entity.dart';
import 'package:evira_e_commerce/features/product_details/domain/entities/product_size_entity.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';

class ProductDetailsEntity extends ProductEntity {
  final String description;
  final List<ProductColorEntity> colors;
  final List<ProductSizeEntity> sizes;
  ProductDetailsEntity({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.price,
    required super.rate,
    required super.sold,
    required super.isFavorite,
    required this.description,
    required this.colors,
    required this.sizes,
  });
}
