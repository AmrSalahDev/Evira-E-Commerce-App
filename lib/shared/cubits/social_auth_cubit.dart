import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/services/social_auth_service.dart';
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

part 'social_auth_state.dart';

@injectable
class SocialAuthCubit extends Cubit<SocialAuthState> {
  final SocialAuthService socialAuthService;
  SocialAuthCubit(this.socialAuthService) : super(SocialAuthInitial());

  Future<void> signInWithFacebook() async {
    try {
      StreamSubscription sub = Stream.empty().listen((event) {});
      await socialAuthService.signInWithFacebook();

      final appLinks = AppLinks();
      sub = appLinks.uriLinkStream.listen((uri) {
        if (uri.host == 'facebook-login') {
          final error = uri.queryParameters['error'];
          final code = uri.queryParameters['code'];
          if (error != null) {
            if (error == 'access_denied') {
              emit(FacebookAuthCanceled());
            } else {
              emit(FacebookAuthFailure(message: error));
            }
          } else if (code != null) {
            emit(FacebookAuthSuccess());
          }
          sub.cancel();
        }
      });
    } catch (e) {
      emit(FacebookAuthFailure(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());
    try {
      await socialAuthService.signInWithGoogle();
      emit(GoogleAuthSuccess());
    } on GoogleSignInException catch (e) {
      if (e.code.name == 'canceled') {
        emit(GoogleAuthCanceled());
      } else {
        emit(GoogleAuthFailure(message: e.toString()));
      }
    } catch (e) {
      emit(GoogleAuthFailure(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit((SignOutLoading()));
    try {
      await socialAuthService.signOut();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure(message: e.toString()));
    }
  }
}
