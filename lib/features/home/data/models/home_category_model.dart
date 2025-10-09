import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_category_entity.dart';

class HomeCategoryModel extends Equatable {
  final String id;
  final String name;
  final String iconUrl;

  const HomeCategoryModel({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, name, iconUrl];

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      iconUrl: json['icon_url'] ?? '',
    );
  }

  HomeCategoryEntity toEntity() =>
      HomeCategoryEntity(id: id, name: name, iconUrl: iconUrl);
}
