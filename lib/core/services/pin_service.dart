import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinService {
  static final _storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _pinKey = 'user_pin';

  static Future<void> savePin(String pin) async {
    if (pin.isEmpty || pin.length < 4) return;

    await _storage.write(key: _pinKey, value: pin);
  }

  static Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  static Future<void> deletePin() async {
    await _storage.delete(key: _pinKey);
  }

  static Future<bool> verifyPin(String pin) async {
    final storedPin = await getPin();
    if (storedPin == pin) {
      return true;
    }
    return false;
  }
}
