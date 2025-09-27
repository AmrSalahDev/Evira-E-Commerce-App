import 'dart:developer';

import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

@LazySingleton()
class BiometricsService {
  final LocalAuthentication localAuth = LocalAuthentication();

  /// Checks if the current device supports biometric authentication in general.
  ///
  /// Returns:
  ///   - `true` if the device supports any form of biometric authentication
  ///     (fingerprint, face unlock, iris, etc.).
  ///   - `false` if the device does not support biometrics or an error occurs.
  ///
  /// Note:
  ///   This only tells you whether the device is capable of biometrics.
  ///   It does NOT guarantee that the user has enrolled any biometric data.
  Future<bool> isDeviceSupported() async {
    log('isDeviceSupported');
    try {
      final bool isDeviceSupported = await localAuth.isDeviceSupported();
      if (isDeviceSupported) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Checks if the device is ready to perform biometric authentication.
  ///
  /// Returns:
  ///   - `true` if the device has biometric hardware AND the user has enrolled
  ///     at least one biometric (e.g., a fingerprint or face).
  ///   - `false` if the device has no biometric hardware, no biometrics are
  ///     enrolled, or an error occurs.
  ///
  /// Note:
  ///   Use this when you want to confirm that biometrics can actually be used,
  ///   not just that the device supports them.
  Future<bool> canCheckBiometrics() async {
    log('canCheckBiometrics');
    try {
      final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Checks if the device specifically supports fingerprint authentication
  /// and the user has enrolled at least one fingerprint.
  ///
  /// Returns:
  ///   - `true` if fingerprint is available and enrolled.
  ///   - `false` if fingerprint is not available or an error occurs.
  ///
  /// Note:
  ///   This uses `getAvailableBiometrics()` to query which types of
  ///   biometrics are currently set up on the device.
  ///   Other types (like face unlock) will not affect this check.
  Future<bool> hasFingerprint() async {
    log('hasFingerprint');
    try {
      final biometrics = await localAuth.getAvailableBiometrics();

      if (biometrics.contains(BiometricType.fingerprint)) {
        return true;
      }

      // On Android 8.1, sometimes the list is empty even if fingerprint exists
      final bool canCheck = await localAuth.canCheckBiometrics;
      return canCheck;
    } catch (e) {
      return false;
    }
  }

  /// Checks if the device specifically supports face authentication
  /// (e.g., Face ID on iOS or face unlock on Android) and the user
  /// has enrolled at least one face profile.
  ///
  /// Returns:
  ///   - `true` if face authentication is available and enrolled.
  ///   - `false` if face authentication is not available or an error occurs.
  ///
  /// Note:
  ///   - On iOS, this maps to Face ID.
  ///   - On Android, this only works on devices that provide face authentication
  ///     through the system’s biometric APIs (BiometricType.face).
  ///   - Some Android devices may not expose face unlock as a strong biometric,
  ///     in which case this will always return `false`.
  Future<bool> hasFaceUnlock() async {
    log('hasFaceUnlock');
    try {
      final biometrics = await localAuth.getAvailableBiometrics();
      return biometrics.contains(BiometricType.face);
    } catch (e) {
      return false;
    }
  }

  Future<void> authenticate({
    required String title,
    required Function() onSuccess,
    required Function(String message) onFailed,
    required Function() onCanceled,
    required Function() onNotEnrolled,
    required Function() onLockedOut,
  }) async {
    try {
      final hasFingerprintSupported =
          await isDeviceSupported() && await canCheckBiometrics();
      if (hasFingerprintSupported) {
        final bool didAuthenticate = await localAuth.authenticate(
          localizedReason: " ",
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: false,
          ),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: title,
              biometricHint: '',
              cancelButton: EviraLang.current.cancel,
            ),
          ],
        );

        if (didAuthenticate) {
          onSuccess.call();
        } else {
          onCanceled.call();
        }
      }
    } on PlatformException catch (e) {
      switch (e.code) {
        case auth_error.notEnrolled:
          onNotEnrolled.call();
          break;
        case auth_error.lockedOut:
          onLockedOut.call();
          break;
        default:
          onFailed.call(e.code);
          break;
      }
    }
  }
}
