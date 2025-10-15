import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/shared/domain/entities/category_entity.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String iconUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, name, iconUrl];

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      iconUrl: json['icon_url'] ?? '',
    );
  }

  CategoryEntity toEntity() =>
      CategoryEntity(id: id, name: name, iconUrl: iconUrl);
}
