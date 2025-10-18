part of 'search_results_bloc.dart';

sealed class SearchResultsEvent extends Equatable {
  const SearchResultsEvent();

  @override
  List<Object> get props => [];
}

class AddRecentKeywordEvent extends SearchResultsEvent {
  final String keyword;

  const AddRecentKeywordEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class GetRecentKeywordsEvent extends SearchResultsEvent {
  final String? keyword;
  const GetRecentKeywordsEvent(this.keyword);

  @override
  List<Object> get props => [keyword ?? ''];
}

class DeleteRecentKeywordEvent extends SearchResultsEvent {
  final int id;

  const DeleteRecentKeywordEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClearAllRecentKeywordsEvent extends SearchResultsEvent {}

class SearchResultEvent extends SearchResultsEvent {
  final String keyword;

  const SearchResultEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}
