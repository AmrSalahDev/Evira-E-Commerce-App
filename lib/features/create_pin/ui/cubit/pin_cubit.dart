import 'package:evira_e_commerce/features/create_pin/domain/usecases/save_pin_usecase.dart';
import 'package:evira_e_commerce/features/create_pin/domain/usecases/verify_pin_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'pin_state.dart';

@injectable
class PinCubit extends Cubit<PinState> {
  final SavePinUsecase savePinUsecase;
  final VerifyPinUsecase verifyPinUsecase;
  PinCubit(this.savePinUsecase, this.verifyPinUsecase) : super(PinInitial());

  Future<void> savePin(String pin) async {
    emit(PinSaving());
    try {
      await savePinUsecase.call(pin);
      print("Pin saved");
      emit(PinSaved());
    } catch (e) {
      emit(PinError("Failed to save PIN"));
    }
  }

  Future<void> verifyPin(String pin) async {
    emit(PinSaving());
    try {
      final storedPin = await verifyPinUsecase.call(pin);
      if (storedPin) {
        emit(PinSaved());
      } else {
        emit(PinError("Incorrect PIN"));
      }
    } catch (e) {
      emit(PinError("Error verifying PIN"));
    }
  }
}
