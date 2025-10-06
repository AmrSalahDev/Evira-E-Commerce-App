part of 'social_auth_cubit.dart';

sealed class SocialAuthState extends Equatable {
  const SocialAuthState();
  @override
  List<Object?> get props => [];
}

class SocialAuthInitial extends SocialAuthState {}

class FacebookAuthLoading extends SocialAuthState {}

class FacebookAuthSuccess extends SocialAuthState {}

class FacebookAuthFailure extends SocialAuthState {
  final String message;
  const FacebookAuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class FacebookAuthCanceled extends SocialAuthState {}

class GoogleAuthLoading extends SocialAuthState {}

class GoogleAuthSuccess extends SocialAuthState {}

class GoogleAuthFailure extends SocialAuthState {
  final String message;
  const GoogleAuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class GoogleAuthCanceled extends SocialAuthState {}

class SignOutLoading extends SocialAuthState {}

class SignOutSuccess extends SocialAuthState {}

class SignOutFailure extends SocialAuthState {
  final String message;
  const SignOutFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
