part of 'fill_profile_cubit.dart';

sealed class FillProfileState extends Equatable {
  const FillProfileState();

  @override
  List<Object> get props => [];
}

final class FillProfileInitial extends FillProfileState {}

class ProfileImageLoading extends FillProfileState {}

class ProfileImageLoaded extends FillProfileState {
  final File file;
  const ProfileImageLoaded(this.file);

  @override
  List<Object> get props => [file];
}

class ProfileImageError extends FillProfileState {
  final String message;
  const ProfileImageError(this.message);

  @override
  List<Object> get props => [message];
}
