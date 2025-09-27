part of 'pin_cubit.dart';

sealed class PinState extends Equatable {
  const PinState();

  @override
  List<Object> get props => [];
}

final class PinInitial extends PinState {}

class PinSaving extends PinState {}

class PinSaved extends PinState {}

class PinError extends PinState {
  final String message;
  const PinError(this.message);

  @override
  List<Object> get props => [message];
}
