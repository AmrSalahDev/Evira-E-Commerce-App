import 'package:evira_e_commerce/core/services/pin_service.dart';
import 'package:evira_e_commerce/features/create_pin/domain/repos/create_pin_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CreatePinRepo)
class CreatePinRepoImpl extends CreatePinRepo {
  @override
  Future<void> savePin(String pin) async {
    await PinService.savePin(pin);
  }

  @override
  Future<bool> verifyPin(String pin) async {
    return await PinService.verifyPin(pin);
  }
}
