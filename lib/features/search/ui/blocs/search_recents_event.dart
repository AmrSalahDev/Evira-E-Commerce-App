part of 'search_recents_bloc.dart';

sealed class SearchRecentsEvent extends Equatable {
  const SearchRecentsEvent();

  @override
  List<Object> get props => [];
}

class AddRecentKeywordEvent extends SearchRecentsEvent {
  final String keyword;

  const AddRecentKeywordEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class GetRecentKeywordsEvent extends SearchRecentsEvent {
  final String? keyword;
  const GetRecentKeywordsEvent(this.keyword);

  @override
  List<Object> get props => [keyword ?? ''];
}

class DeleteRecentKeywordEvent extends SearchRecentsEvent {
  final int id;

  const DeleteRecentKeywordEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClearAllRecentKeywordsEvent extends SearchRecentsEvent {}
