import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

part 'app_flow_state.dart';

@lazySingleton
class AppFlowCubit extends Cubit<AppFlowState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  StreamSubscription<AuthState>? _authSub;
  late final StreamSubscription<InternetStatus> _internetSub;
  late final AppLifecycleListener _listener;

  AppFlowCubit() : super(AppFlowInitial()) {
    _internetSub = InternetConnection().onStatusChange.listen((status) async {
      switch (status) {
        case InternetStatus.disconnected:
          emit(AppFlowPathState(AppPaths.noInternet));
          FlutterNativeSplash.remove();
          break;

        case InternetStatus.connected:
          final hasAccess = await InternetConnection().hasInternetAccess;
          if (hasAccess) {
            // Always re-check state immediately
            await checkUserState();

            // Attach auth listener only once
            _authSub ??= _supabase.auth.onAuthStateChange.listen((_) {
              checkUserState();
            });
          } else {
            // Connected to WiFi/4G but no internet (e.g. captive portal)
            emit(AppFlowPathState(AppPaths.noInternet));
            FlutterNativeSplash.remove();
          }

          break;
      }
    });

    _listener = AppLifecycleListener(
      onResume: () => _internetSub.resume(),
      onHide: () => _internetSub.pause(),
      onPause: () => _internetSub.pause(),
    );
  }

  Future<void> checkUserState() async {
    final user = _supabase.auth.currentUser;
    final session = _supabase.auth.currentSession;

    if (user == null || session == null) {
      emit(AppFlowPathState(AppPaths.onboarding));
      FlutterNativeSplash.remove();
      return;
    }

    // query user info
    final data = await _supabase
        .from('users')
        .select('is_profile_filled, has_pin, has_fingerprint')
        .eq('id', user.id)
        .maybeSingle();

    final isProfileFilled = data?['is_profile_filled'] ?? false;
    final hasPin = data?['has_pin'] ?? false;
    final hasFingerprint = data?['has_fingerprint'] ?? false;

    if (!isProfileFilled) {
      emit(AppFlowPathState(AppPaths.fillProfile));
    } else if (!hasPin) {
      emit(AppFlowPathState(AppPaths.createPin));
    } else if (!hasFingerprint) {
      emit(AppFlowPathState(AppPaths.setFingerprint));
    } else {
      emit(AppFlowPathState(AppPaths.home));
    }

    // hide splash only after deciding
    FlutterNativeSplash.remove();
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    _internetSub.cancel();
    _listener.dispose();
    return super.close();
  }
}
