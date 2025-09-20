part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingPageState extends OnboardingState {
  final int page;
  const OnboardingPageState(this.page);

  @override
  List<Object> get props => [page];
}
