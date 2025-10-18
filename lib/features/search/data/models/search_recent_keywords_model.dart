import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';

class SearchRecentKeywordsModel {
  final int id;
  final String keyword;

  SearchRecentKeywordsModel({required this.id, required this.keyword});

  factory SearchRecentKeywordsModel.fromJson(Map<String, dynamic> json) {
    return SearchRecentKeywordsModel(
      id: json['id'] as int,
      keyword: json['keyword'] as String,
    );
  }

  SearchRecentKeywordsEntity toEntity() {
    return SearchRecentKeywordsEntity(id: id, keyword: keyword);
  }
}
