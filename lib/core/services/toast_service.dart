import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:toastification/toastification.dart';

@immutable
sealed class IToastService {
  void showSuccessToast({BuildContext? context, required String message});
  void showErrorToast({BuildContext? context, required String message});
  void showInfoToast({BuildContext? context, required String message});
  void showWarningToast({BuildContext? context, required String message});
}

@LazySingleton()
class ToastService implements IToastService {
  @override
  void showErrorToast({BuildContext? context, required String message}) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topCenter,
      backgroundColor: context!.containerColor,
      foregroundColor: context.textColor,
      borderSide: BorderSide(color: context.containerBorderColor),
    );
  }

  @override
  void showInfoToast({BuildContext? context, required String message}) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topCenter,
      backgroundColor: context!.containerColor,
      foregroundColor: context.textColor,
      borderSide: BorderSide(color: context.containerBorderColor),
    );
  }

  @override
  void showSuccessToast({BuildContext? context, required String message}) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topCenter,
      backgroundColor: context!.containerColor,
      foregroundColor: context.textColor,
      borderSide: BorderSide(color: context.containerBorderColor),
    );
  }

  @override
  void showWarningToast({BuildContext? context, required String message}) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.warning,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topCenter,
      backgroundColor: context!.containerColor,
      foregroundColor: context.textColor,
      borderSide: BorderSide(color: context.containerBorderColor),
    );
  }
}
