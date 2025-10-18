part of 'search_results_bloc.dart';

sealed class SearchResultsState extends Equatable {
  const SearchResultsState();

  @override
  List<Object> get props => [];
}

final class SearchResultsInitial extends SearchResultsState {}

final class SearchResultLoading extends SearchResultsState {}

final class SearchResultLoaded extends SearchResultsState {
  final List<ResultProductsEntity> products;
  const SearchResultLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

final class SearchResultError extends SearchResultsState {
  final String message;
  const SearchResultError({required this.message});

  @override
  List<Object> get props => [message];
}
