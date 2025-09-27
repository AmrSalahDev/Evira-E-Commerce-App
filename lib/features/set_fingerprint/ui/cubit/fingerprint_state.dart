part of 'fingerprint_cubit.dart';

sealed class FingerprintState extends Equatable {
  const FingerprintState();

  @override
  List<Object> get props => [];
}

final class FingerprintInitial extends FingerprintState {}

final class FingerprintSuccess extends FingerprintState {}

final class FingerprintError extends FingerprintState {
  final String message;
  const FingerprintError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FingerprintLoading extends FingerprintState {}

final class FingerprintNotEnrolled extends FingerprintState {}

final class FingerprintNotSupported extends FingerprintState {}

final class FingerprintCanceled extends FingerprintState {}

final class FingerprintLockedOut extends FingerprintState {}
