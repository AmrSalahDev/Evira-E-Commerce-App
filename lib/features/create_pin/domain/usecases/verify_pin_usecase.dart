import 'package:evira_e_commerce/features/create_pin/domain/repos/create_pin_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyPinUsecase {
  final CreatePinRepo repo;
  VerifyPinUsecase(this.repo);
  Future<bool> call(String pin) => repo.verifyPin(pin);
}
