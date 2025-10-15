part of 'special_offers_bloc.dart';

sealed class SpecialOffersEvent extends Equatable {
  const SpecialOffersEvent();

  @override
  List<Object> get props => [];
}

class GetSpecialOffersEvent extends SpecialOffersEvent {}
