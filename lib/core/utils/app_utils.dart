import 'dart:async';
import 'dart:io';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';

class AppUtils {
  AppUtils._();

  // static String countryCodeToEmoji(String countryCode) {
  //   // 0x41 is Letter A
  //   // 0x1F1E6 is Regional Indicator Symbol Letter A
  //   // Example :
  //   // firstLetter U => 20 + 0x1F1E6
  //   // secondLetter S => 18 + 0x1F1E6
  //   // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  //   final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
  //   final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
  //   return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  // }

  static FutureOr<void> handleCode({
    required Function() code,
    required Function(String message)? onNoInternet,
    required Function(String message) onError,
  }) async {
    try {
      final result = code();

      // If the result is a Future → await it
      if (result is Future) {
        await result;
      }
    } on SocketException catch (_) {
      onNoInternet?.call(EviraLang.current.noInternetConnection);
    } on TimeoutException catch (_) {
      onNoInternet?.call(EviraLang.current.noInternetConnection);
    } catch (e) {
      onError(e.toString());
    }
  }
}
