import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/features/auth/ui/screen/auth_screen.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/screen/fill_profile_screen.dart';
import 'package:evira_e_commerce/features/home/ui/screen/home_screen.dart';
import 'package:evira_e_commerce/features/login/ui/screen/login_screen.dart';
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:evira_e_commerce/features/onboarding/ui/screen/on_boarding_screen.dart';
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
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPaths.fillProfile,
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
          return const FillProfileScreen();
        },
      ),
    ],
  );
}
