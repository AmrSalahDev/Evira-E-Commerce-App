import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

part 'app_flow_state.dart';

@lazySingleton
class AppFlowCubit extends Cubit<AppFlowState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  StreamSubscription<AuthState>? _authSub;

  AppFlowCubit() : super(AppFlowInitial()) {
    checkUserState();
    _authSub ??= _supabase.auth.onAuthStateChange.listen((_) {
      checkUserState();
    });
  }

  Future<void> checkUserState() async {
    try {
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
      //.timeout(const Duration(seconds: 10)); // optional: prevent hanging

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
    } on TimeoutException catch (_) {
      emit(AppFlowPathState(AppPaths.noInternet));
    } on SocketException catch (_) {
      emit(AppFlowPathState(AppPaths.noInternet));
    } catch (e) {
      // fallback for any unexpected error
      emit(AppFlowPathState(AppPaths.error));
    } finally {
      FlutterNativeSplash.remove();
    }
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
