import 'dart:async';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetLifecycleWrapper extends StatefulWidget {
  final Widget child;

  final void Function(String message)? onConnected;
  final void Function(String message)? onDisconnected;
  final void Function(String message)? onConnectedButHasNoInternet;

  static ValueNotifier<bool> internetAvailable = ValueNotifier(true);

  const InternetLifecycleWrapper({
    super.key,
    required this.child,
    this.onConnected,
    this.onDisconnected,
    this.onConnectedButHasNoInternet,
  });

  @override
  State<InternetLifecycleWrapper> createState() =>
      _InternetLifecycleWrapperState();
}

class _InternetLifecycleWrapperState extends State<InternetLifecycleWrapper> {
  late final StreamSubscription<InternetStatus> _subscription;
  late final AppLifecycleListener _listener;
  bool _firstCheck = true;

  @override
  void initState() {
    super.initState();

    _subscription = InternetConnection().onStatusChange.listen((status) async {
      switch (status) {
        case InternetStatus.disconnected:
          InternetLifecycleWrapper.internetAvailable.value = false;

          // show immediately if first check is disconnected
          if (!_firstCheck || _firstCheck) {
            debugPrint('Disconnected');
            widget.onDisconnected?.call(EviraLang.current.noInternet);
          }
          break;

        case InternetStatus.connected:
          final hasAccess = await InternetConnection().hasInternetAccess;
          InternetLifecycleWrapper.internetAvailable.value = hasAccess;

          if (_firstCheck) {
            // First time: only act if NO internet access
            if (!hasAccess) {
              debugPrint('Connected but no internet (first time)');
              widget.onConnectedButHasNoInternet?.call(
                EviraLang.current.connectedWithoutInternet,
              );
            }
          } else {
            // Later checks: show messages normally
            if (hasAccess) {
              debugPrint('Connected');
              widget.onConnected?.call(EviraLang.current.backOnline);
            } else {
              debugPrint('Connected but no internet');
              widget.onConnectedButHasNoInternet?.call(
                EviraLang.current.connectedWithoutInternet,
              );
            }
          }
          break;
      }

      // mark first check as done
      _firstCheck = false;
    });

    _listener = AppLifecycleListener(
      onResume: _subscription.resume,
      onHide: _subscription.pause,
      onPause: _subscription.pause,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
