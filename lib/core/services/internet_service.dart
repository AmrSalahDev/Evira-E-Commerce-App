import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetService {
  static Future<bool> handleNoInternetMessage(BuildContext context) async {
    final status = await InternetConnection().internetStatus;

    if (context.mounted) {
      if (status == InternetStatus.disconnected) {
        getIt<ToastService>().showErrorToast(
          context: context,
          message: EviraLang.of(context).noInternet,
        );
        return false;
      }
    }
    return true;
  }
}
