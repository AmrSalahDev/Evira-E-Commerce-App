import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/biometrics_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'fingerprint_state.dart';

@injectable
class FingerprintCubit extends Cubit<FingerprintState> {
  FingerprintCubit() : super(FingerprintInitial());

  Future<void> authenticate() async {
    emit(FingerprintLoading());
    await getIt<BiometricsService>().authenticate(
      title: EviraLang.current.confirmBiometric,
      onSuccess: () {
        emit(FingerprintSuccess());
      },
      onFailed: (message) {
        print(message);
        emit(FingerprintError(message: message));
      },
      onNotEnrolled: () {
        emit(FingerprintNotEnrolled());
      },
      onCanceled: () {
        emit(FingerprintCanceled());
      },
      onLockedOut: () {
        emit(FingerprintLockedOut());
      },
    );
    emit(FingerprintInitial());
  }
}
