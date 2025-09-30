import 'package:evira_e_commerce/features/signup/domain/usecases/signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupUsecase signupUsecase;
  SignupCubit(this.signupUsecase) : super(SignupInitial());

  Future<void> signup({
    required String email,
    required String password,
    required bool remember,
  }) async {
    emit(SignupLoading());
    try {
      final String? errorMessage = await signupUsecase.call(
        email: email,
        password: password,
        remember: remember,
      );
      if (errorMessage != null) {
        emit(SignupError(message: errorMessage));
      } else {
        emit(SignupSuccess());
      }
    } catch (e) {
      emit(SignupError(message: e.toString()));
    }
  }
}
