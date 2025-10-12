import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart';
import 'package:evira_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:evira_e_commerce/features/signup/domain/entities/signup_entity.dart';
import 'package:evira_e_commerce/features/signup/domain/usecases/signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupUsecase signupUsecase;
  SignupCubit(this.signupUsecase) : super(SignupInitial());

  Future<void> signup({required SignupEntity signupEntity}) async {
    emit(SignupLoading());
    try {
      bool result = await signupUsecase.call(signupEntity: signupEntity);
      if (result) {
        emit(SignupSuccess());
      } else {
        emit(SignupError(message: EviraLang.current.unknownError));
      }
    } on AuthException catch (e) {
      emit(SignupError(message: commonErrors(e.code ?? e.message)));
    } catch (e) {
      return emit(SignupError(message: e.toString()));
    }
  }

  String commonErrors(String code) {
    switch (code) {
      case 'weak-password':
        return EviraLang.current.passwordTooWeak;
      case 'user_already_exists':
      case 'email_exists':
        return EviraLang.current.emailAlreadyInUse;
      case 'email_address_invalid':
        return EviraLang.current.invalidEmail;
      case 'over_email_send_rate_limit':
        return EviraLang.current.tooManyRequests;

      // case 'operation-not-allowed':
      //   return EviraLang.current.operationNotAllowed;
      // case 'network-request-failed':
      //   return EviraLang.current.networkError;
      default:
        return EviraLang.current.unknownError;
    }
  }
}
