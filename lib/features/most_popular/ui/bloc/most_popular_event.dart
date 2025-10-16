part of 'most_popular_bloc.dart';

sealed class MostPopularEvent extends Equatable {
  const MostPopularEvent();

  @override
  List<Object> get props => [];
}

class GetMostPopularProducts extends MostPopularEvent {
  final int categoryId;
  const GetMostPopularProducts({this.categoryId = 0});
}
