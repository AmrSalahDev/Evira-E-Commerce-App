import 'package:evira_e_commerce/features/product_details/domain/entities/product_size_entity.dart';

class ProductSizeModel {
  final String sizeLabel;

  const ProductSizeModel({required this.sizeLabel});

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(sizeLabel: json['size_label'] ?? '');
  }

  ProductSizeEntity toEntity() => ProductSizeEntity(sizeLabel: sizeLabel);
}
