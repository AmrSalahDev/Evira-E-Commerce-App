abstract class CreatePinRepo {
  Future<void> savePin(String pin);
  Future<bool> verifyPin(String pin);
}
