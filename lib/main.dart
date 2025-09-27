import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies();

  runApp(
    BlocProvider.value(value: getIt<ThemeCubit>(), child: const EviraApp()),
  );
  FlutterNativeSplash.remove();
}

class EviraApp extends StatelessWidget {
  const EviraApp({super.key});
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
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
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
              themeMode: ThemeMode.dark,
              builder: (context, child) {
                final isDark = Theme.of(context).brightness == Brightness.dark;

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
            ),
          );
        },
      ),
    );
  }
}
