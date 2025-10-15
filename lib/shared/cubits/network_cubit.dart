import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'network_state.dart';

@lazySingleton
class NetworkCubit extends Cubit<NetworkState> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  AppLifecycleListener? _appLifecycleListener;
  Timer? _debounceTimer;

  NetworkCubit() : super(NetworkInitial()) {
    startMonitoring();
  }

  void startMonitoring() {
    _subscription ??= Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      // Received changes in available connectivity types!
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(seconds: 1), () async {
        await _onStatusChange(result);
      });
    });

    _appLifecycleListener ??= AppLifecycleListener(
      onResume: _subscription?.resume,
      onHide: _subscription?.pause,
      onPause: _subscription?.pause,
    );
  }

  Future<void> _onStatusChange(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      debugPrint('Disconnected');
      emit(NetworkDisconnected());
    } else {
      debugPrint('Connected');
      emit(NetworkConnected());
    }
  }

  // AuthRetryableFetchException

  void stopMonitoring() {
    _subscription?.cancel();
    _appLifecycleListener?.dispose();
    _debounceTimer?.cancel();
  }

  @override
  Future<void> close() {
    stopMonitoring();
    return super.close();
  }
}
