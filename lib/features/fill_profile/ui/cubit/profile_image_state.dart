part of 'profile_image_cubit.dart';

sealed class ProfileImageState extends Equatable {
  const ProfileImageState();
  @override
  List<Object?> get props => [];
}

class ProfileImageInitial extends ProfileImageState {}

class ProfileImageLoading extends ProfileImageState {}

class ProfileImageLoaded extends ProfileImageState {
  final File file;
  const ProfileImageLoaded(this.file);

  @override
  List<Object> get props => [file];
}

class ProfileImageError extends ProfileImageState {
  final String message;
  const ProfileImageError(this.message);

  @override
  List<Object> get props => [message];
}
