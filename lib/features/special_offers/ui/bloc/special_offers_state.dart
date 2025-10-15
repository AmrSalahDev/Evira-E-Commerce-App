part of 'special_offers_bloc.dart';

sealed class SpecialOffersState extends Equatable {
  const SpecialOffersState();

  @override
  List<Object> get props => [];
}

final class SpecialOffersInitial extends SpecialOffersState {}

final class SpecialOffersLoaded extends SpecialOffersState {
  final List<SpecialOfferEntity> specialOffers;
  const SpecialOffersLoaded(this.specialOffers);
}

final class SpecialOffersError extends SpecialOffersState {
  final String message;
  const SpecialOffersError(this.message);

  @override
  List<Object> get props => [message];
}

final class SpecialOffersLoading extends SpecialOffersState {}
