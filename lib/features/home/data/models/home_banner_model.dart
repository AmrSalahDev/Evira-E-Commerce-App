import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/shared/domain/entities/banner_entity.dart';

class HomeBannerModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String discount;

  const HomeBannerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discount,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, discount];

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      discount: json['discount'] ?? '',
    );
  }

  BannerEntity toEntity() => BannerEntity(
    id: id,
    title: title,
    description: description,
    imageUrl: imageUrl,
    discount: discount,
  );
}
