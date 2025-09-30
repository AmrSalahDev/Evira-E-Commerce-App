part of 'fill_profile_cubit.dart';

sealed class FillProfileState extends Equatable {
  const FillProfileState();

  @override
  List<Object> get props => [];
}

final class FillProfileInitial extends FillProfileState {}

final class FillProfileLoading extends FillProfileState {}

final class FillProfileSuccess extends FillProfileState {}

final class FillProfileError extends FillProfileState {
  final String message;
  const FillProfileError(this.message);
}

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

class ProfileShowDatePickerLoading extends FillProfileState {}

class ProfileShowDatePickerLoaded extends FillProfileState {
  final String datePicked;
  const ProfileShowDatePickerLoaded(this.datePicked);

  @override
  List<Object> get props => [datePicked];
}

class ProfileShowDatePickerError extends FillProfileState {
  final String message;
  const ProfileShowDatePickerError(this.message);

  @override
  List<Object> get props => [message];
}
