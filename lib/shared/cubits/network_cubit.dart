import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'network_state.dart';

@lazySingleton
class NetworkCubit extends Cubit<NetworkState> {
  StreamSubscription<InternetStatus>? _subscription;
  AppLifecycleListener? _listener;
  Timer? _debounceTimer;
  bool _firstCheck = true;

  NetworkCubit() : super(NetworkInitial()) {
    startChecking();
  }

  void startChecking() {
    _subscription ??= InternetConnection().onStatusChange.listen((status) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
        await _onStatusChange(status);
      });
    });

    _listener ??= AppLifecycleListener(
      onResume: _subscription?.resume,
      onHide: _subscription?.pause,
      onPause: _subscription?.pause,
    );
  }

  Future<void> _onStatusChange(InternetStatus status) async {
    switch (status) {
      case InternetStatus.disconnected:
        if (!_firstCheck || _firstCheck) {
          debugPrint('Disconnected');
          emit(NetworkDisconnected());
        }
        break;
      case InternetStatus.connected:
        final hasAccess = await InternetConnection().hasInternetAccess;

        if (_firstCheck) {
          if (!hasAccess) {
            debugPrint('Connected but no internet (first time)');
            emit(NetworkDisconnected());
          }
        } else {
          if (hasAccess) {
            debugPrint('Connected');
            emit(NetworkConnected());
          } else {
            debugPrint('Connected but no internet');
            emit(NetworkDisconnected());
          }
        }
        break;
    }
    _firstCheck = false;
  }

  void stopChecking() {
    _subscription?.cancel();
    _listener?.dispose();
    _debounceTimer?.cancel();
  }

  @override
  Future<void> close() {
    stopChecking();
    return super.close();
  }
}
