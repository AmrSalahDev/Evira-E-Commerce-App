part of 'most_popular_bloc.dart';

sealed class MostPopularState extends Equatable {
  const MostPopularState();

  @override
  List<Object> get props => [];
}

final class MostPopularInitial extends MostPopularState {}

final class MostPopularLoaded extends MostPopularState {
  final List<MostPopularEntity> products;

  const MostPopularLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class MostPopularError extends MostPopularState {
  final String message;

  const MostPopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class MostPopularLoading extends MostPopularState {}
