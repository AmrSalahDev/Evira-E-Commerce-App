import 'dart:async';

import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/features/error/ui/screen/error_screen.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart';
import 'package:evira_e_commerce/features/login/ui/cubit/login_cubit.dart';
import 'package:evira_e_commerce/features/no_internet/ui/screen/no_internet_screen.dart';
import 'package:evira_e_commerce/features/social_auth/ui/screen/social_auth_screen.dart';
import 'package:evira_e_commerce/features/create_new_password/ui/screen/create_new_password_screen.dart';
import 'package:evira_e_commerce/features/create_pin/ui/cubit/pin_cubit.dart';
import 'package:evira_e_commerce/features/create_pin/ui/screen/create_pin_screen.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/profile_image_cubit.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/screen/fill_profile_screen.dart';
import 'package:evira_e_commerce/features/forget_password/ui/screens/forgot_password_otp_screen.dart';
import 'package:evira_e_commerce/features/forget_password/ui/screens/forgot_password_screen.dart';
import 'package:evira_e_commerce/features/home/ui/screen/home_screen.dart';
import 'package:evira_e_commerce/features/login/ui/screen/login_screen.dart';
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:evira_e_commerce/features/onboarding/ui/screen/on_boarding_screen.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/cubit/fingerprint_cubit.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/screen/set_fingerprint_screen.dart';
import 'package:evira_e_commerce/features/signup/ui/cubit/signup_cubit.dart';
import 'package:evira_e_commerce/features/signup/ui/screen/signup_screen.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/social_auth_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

class AppPaths {
  static final String onboarding = '/onboarding';
  static final String auth = '/socialAuth';
  static final String home = '/home';
  static final String signUp = '/signUp';
  static final String login = '/login';
  static final String fillProfile = '/fillProfile';
  static final String createPin = '/createPin';
  static final String setFingerprint = '/setFingerprint';
  static final String forgotPassword = '/forgotPassword';
  static final String forgotPasswordVerify = '/forgotPasswordVerify';
  static final String createNewPassword = '/createNewPassword';
  static final String noInternet = '/noInternet';
  static final String error = '/error';
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static GoRouter createRouter(AppFlowCubit appFlowCubit, String path) {
    return GoRouter(
      initialLocation: path,
      refreshListenable: GoRouterRefreshStream(appFlowCubit.stream),
      routes: <RouteBase>[
        GoRoute(
          path: AppPaths.onboarding,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<OnboardingCubit>(),
              child: OnBoardingScreen(),
            );
          },
        ),

        GoRoute(
          path: AppPaths.home,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<HomeAppBarCubit>()),
                BlocProvider(create: (context) => getIt<GreetingCubit>()),
                BlocProvider(create: (context) => getIt<HomeBannerCubit>()),
              ],
              child: const HomeScreen(),
            );
          },
        ),

        GoRoute(
          path: AppPaths.error,
          builder: (context, state) => ErrorScreen(error: ''),
        ),

        GoRoute(
          path: AppPaths.noInternet,
          builder: (context, state) {
            final extra = state.extra as NoInternetScreenArgs?;
            return NoInternetScreen(args: extra);
          },
        ),

        GoRoute(
          path: AppPaths.auth,
          pageBuilder: GoTransitions.slide.toLeft.withFade.call,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<SocialAuthCubit>(),
              child: const SocialAuthScreen(),
            );
          },
        ),
        GoRoute(
          path: AppPaths.signUp,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<TextFieldCubit>()),
                BlocProvider(create: (context) => getIt<SignupCubit>()),
                BlocProvider(create: (context) => getIt<SocialAuthCubit>()),
              ],
              child: const SignupScreen(),
            );
          },
        ),
        GoRoute(
          path: AppPaths.login,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<TextFieldCubit>()),
                BlocProvider(create: (context) => getIt<LoginCubit>()),
                BlocProvider(create: (context) => getIt<SocialAuthCubit>()),
              ],
              child: const LoginScreen(),
            );
          },
        ),

        GoRoute(
          path: AppPaths.fillProfile,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<TextFieldCubit>()),
                BlocProvider(create: (context) => getIt<FillProfileCubit>()),
                BlocProvider(create: (context) => getIt<ProfileImageCubit>()),
              ],
              child: FillProfileScreen(),
            );
          },
        ),

        GoRoute(
          path: AppPaths.createPin,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<PinCubit>(),
              child: const CreatePinScreen(),
            );
          },
        ),

        GoRoute(
          path: AppPaths.setFingerprint,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<FingerprintCubit>(),
              child: const SetFingerprintScreen(),
            );
          },
        ),

        GoRoute(
          path: AppPaths.forgotPassword,
          builder: (context, state) {
            return const ForgetPasswordScreen();
          },
        ),

        GoRoute(
          path: AppPaths.forgotPasswordVerify,
          builder: (context, state) {
            return const ForgotPasswordOtpScreen();
          },
        ),

        GoRoute(
          path: AppPaths.createNewPassword,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<TextFieldCubit>(),
              child: const CreateNewPasswordScreen(),
            );
          },
        ),
      ],
      //errorBuilder: (context, state) => ErrorScreen(error: state.error?.message),
      onException: (context, state, router) {},
    );
  }
}
