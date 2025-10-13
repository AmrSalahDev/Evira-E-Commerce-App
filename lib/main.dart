import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';

import 'package:evira_e_commerce/firebase_options.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize dotenv
  await dotenv.load(fileName: ".env");

  // initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialize supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
  );

  // initialize dependencies
  configureDependencies();

  // initialize hive
  //await Hive.initFlutter();

  final appFlowCubit = getIt<AppFlowCubit>();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<NetworkCubit>()),
      ],
      child: EviraApp(appFlowCubit: appFlowCubit),
    ),
  );
  // FlutterNativeSplash.remove();
}

class EviraApp extends StatelessWidget {
  final AppFlowCubit appFlowCubit;
  const EviraApp({super.key, required this.appFlowCubit});

  @override
  Widget build(BuildContext context) {
    /// Set default transition values for all `GoTransition`.
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 400);

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final theme = themeMode == ThemeMode.dark
              ? AppTheme.dark
              : AppTheme.light;
          return AnimatedTheme(
            data: theme,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: BlocProvider.value(
              value: appFlowCubit,
              child: BlocSelector<AppFlowCubit, AppFlowState, String>(
                selector: (state) {
                  return state is AppFlowPathState
                      ? state.path
                      : AppPaths.onboarding;
                },
                builder: (context, path) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    routerConfig: AppRouter.createRouter(appFlowCubit, path),
                    locale: const Locale('en'),
                    localizationsDelegates: [
                      EviraLang.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: EviraLang.delegate.supportedLocales,
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: themeMode,
                    builder: (context, child) {
                      final isDark =
                          Theme.of(context).brightness == Brightness.dark;

                      return SystemUIWrapper(
                        statusBarColor: context.backgroundColor,
                        statusBarIconBrightness: isDark
                            ? Brightness.light
                            : Brightness.dark,
                        navigationBarColor: context.backgroundColor,
                        navigationBarIconBrightness: isDark
                            ? Brightness.light
                            : Brightness.dark,
                        child: child!,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
