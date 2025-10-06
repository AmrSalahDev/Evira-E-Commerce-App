import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/features/create_pin/domain/usecases/save_pin_usecase.dart';
import 'package:evira_e_commerce/features/create_pin/domain/usecases/verify_pin_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'pin_state.dart';

@injectable
class PinCubit extends Cubit<PinState> {
  final SavePinUsecase savePinUsecase;
  final VerifyPinUsecase verifyPinUsecase;
  PinCubit(this.savePinUsecase, this.verifyPinUsecase) : super(PinInitial());

  Future<void> registerPin() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      await Supabase.instance.client
          .from('users')
          .update({'has_pin': true})
          .eq('id', user.id);
    }
  }

  Future<void> savePin(String pin) async {
    emit(PinSaving());
    try {
      await savePinUsecase.call(pin);
      emit(PinSaved());
    } catch (e) {
      emit(PinError(EviraLang.current.failedToSavePIN));
    }
  }

  Future<void> verifyPin(String pin) async {
    emit(PinSaving());
    try {
      final storedPin = await verifyPinUsecase.call(pin);
      if (storedPin) {
        emit(PinSaved());
      } else {
        emit(PinError(EviraLang.current.incorrectPIN));
      }
    } catch (e) {
      emit(PinError(EviraLang.current.errorverifyingPIN));
    }
  }
}
