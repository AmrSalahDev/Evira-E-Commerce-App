import 'package:evira_e_commerce/features/product_details/domain/entities/product_color_entity.dart';

class ProductColorModel {
  final String colorName;
  final String? colorHex;

  const ProductColorModel({required this.colorName, this.colorHex});

  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      colorName: json['color_name'] ?? '',
      colorHex: json['color_hex'],
    );
  }

  ProductColorEntity toEntity() =>
      ProductColorEntity(colorName: colorName, colorHex: colorHex);
}
