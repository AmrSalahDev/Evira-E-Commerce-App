// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:evira_e_commerce/core/services/theme_service.dart' as _i193;
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart'
    as _i672;
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart' as _i669;
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart' as _i436;
import 'package:evira_e_commerce/shared/domain/usecases/get_theme_mode_usecase.dart'
    as _i820;
import 'package:evira_e_commerce/shared/domain/usecases/set_theme_mode_usecase.dart'
    as _i733;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i672.OnboardingCubit>(() => _i672.OnboardingCubit());
    gh.factory<_i669.TextFieldCubit>(() => _i669.TextFieldCubit());
    gh.lazySingleton<_i193.ThemeService>(() => _i193.ThemeService());
    gh.factory<_i820.GetThemeModeUseCase>(
      () => _i820.GetThemeModeUseCase(gh<_i193.ThemeService>()),
    );
    gh.factory<_i733.SetThemeModeUseCase>(
      () => _i733.SetThemeModeUseCase(gh<_i193.ThemeService>()),
    );
    gh.lazySingleton<_i436.ThemeCubit>(
      () => _i436.ThemeCubit(
        gh<_i820.GetThemeModeUseCase>(),
        gh<_i733.SetThemeModeUseCase>(),
      ),
    );
    return this;
  }
}
