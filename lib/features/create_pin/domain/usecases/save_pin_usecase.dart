import 'package:evira_e_commerce/features/create_pin/domain/repos/create_pin_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavePinUsecase {
  final CreatePinRepo repo;

  SavePinUsecase(this.repo);

  Future<void> call(String pin) => repo.savePin(pin);
}
