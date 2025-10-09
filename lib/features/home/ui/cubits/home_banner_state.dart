part of 'home_banner_cubit.dart';

sealed class HomeBannerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeBannerInitial extends HomeBannerState {}

class HomeBannerLoading extends HomeBannerState {}

class HomeBannerLoaded extends HomeBannerState {
  final List<HomeBannerEntity> banners;
  HomeBannerLoaded(this.banners);

  @override
  List<Object?> get props => [banners];
}

class HomeBannerError extends HomeBannerState {
  final String message;
  HomeBannerError(this.message);

  @override
  List<Object?> get props => [message];
}
