import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/features/auth/ui/screen/auth_screen.dart';
import 'package:evira_e_commerce/features/create_pin/ui/cubit/pin_cubit.dart';
import 'package:evira_e_commerce/features/create_pin/ui/screen/create_pin_screen.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/screen/fill_profile_screen.dart';
import 'package:evira_e_commerce/features/forget_password/ui/screens/forgot_password_otp_screen.dart';
import 'package:evira_e_commerce/features/forget_password/ui/screens/forgot_password_screen.dart';
import 'package:evira_e_commerce/features/home/ui/screen/home_screen.dart';
import 'package:evira_e_commerce/features/login/ui/screen/login_screen.dart';
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:evira_e_commerce/features/onboarding/ui/screen/on_boarding_screen.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/cubit/fingerprint_cubit.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/screen/set_fingerprint_screen.dart';
import 'package:evira_e_commerce/features/signup/ui/screen/signup_screen.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

class AppPaths {
  static final String onboarding = '/onboarding';
  static final String auth = '/auth';
  static final String home = '/home';
  static final String signUp = '/signUp';
  static final String login = '/login';
  static final String fillProfile = '/fillProfile';
  static final String createPin = '/createPin';
  static final String setFingerprint = '/setFingerprint';
  static final String forgotPassword = '/forgotPassword';
  static final String forgotPasswordVerify = '/forgotPasswordVerify';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPaths.auth,
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
          return const HomeScreen();
        },
      ),

      GoRoute(
        path: AppPaths.auth,
        pageBuilder: GoTransitions.slide.toLeft.withFade.call,
        builder: (context, state) {
          return const AuthScreen();
        },
      ),
      GoRoute(
        path: AppPaths.signUp,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<TextFieldCubit>(),
            child: const SignupScreen(),
          );
        },
      ),
      GoRoute(
        path: AppPaths.login,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<TextFieldCubit>(),
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
            ],
            child: const FillProfileScreen(),
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
    ],
  );
}
