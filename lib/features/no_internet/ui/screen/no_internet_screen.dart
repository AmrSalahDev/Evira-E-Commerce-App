import 'dart:async';

import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with StatefulScreenMixin {
  bool _checking = false;

  @override
  String get title => "No Internet";

  Future<void> _tryAgain() async {
    setState(() => _checking = true);

    final hasAccess = await InternetConnection().hasInternetAccess;

    if (!mounted) return;

    setState(() => _checking = false);

    if (hasAccess) {
      // Pop back → AppFlowCubit will re-check and redirect
      context.read<AppFlowCubit>().checkUserState();
    } else {
      getIt<ToastService>().showErrorToast(
        context: context,
        message: "Still no internet connection.",
      );
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Please check your Wi-Fi or mobile data and try again.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checking ? null : _tryAgain,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _checking
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
