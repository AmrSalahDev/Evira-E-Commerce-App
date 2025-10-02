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
