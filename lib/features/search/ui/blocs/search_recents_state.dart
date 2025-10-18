part of 'search_recents_bloc.dart';

sealed class SearchRecentsState extends Equatable {
  const SearchRecentsState();

  @override
  List<Object> get props => [];
}

final class SearchRecentsInitial extends SearchRecentsState {}

final class SearchRecentKeywordsLoading extends SearchRecentsState {}

final class SearchRecentKeywordsLoaded extends SearchRecentsState {
  final List<SearchRecentKeywordsEntity> keywords;
  const SearchRecentKeywordsLoaded({required this.keywords});

  @override
  List<Object> get props => [keywords];
}

final class SearchRecentKeywordsError extends SearchRecentsState {
  final String message;
  const SearchRecentKeywordsError({required this.message});

  @override
  List<Object> get props => [message];
}
