// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:evira_e_commerce/core/services/biometrics_service.dart'
    as _i858;
import 'package:evira_e_commerce/core/services/shared_preferences_service.dart'
    as _i7;
import 'package:evira_e_commerce/core/services/social_auth_service.dart'
    as _i769;
import 'package:evira_e_commerce/core/services/theme_service.dart' as _i193;
import 'package:evira_e_commerce/core/services/toast_service.dart' as _i101;
import 'package:evira_e_commerce/features/create_pin/data/repos/create_pin_repo_impl.dart'
    as _i825;
import 'package:evira_e_commerce/features/create_pin/domain/repos/create_pin_repo.dart'
    as _i1030;
import 'package:evira_e_commerce/features/create_pin/domain/usecases/save_pin_usecase.dart'
    as _i419;
import 'package:evira_e_commerce/features/create_pin/domain/usecases/verify_pin_usecase.dart'
    as _i831;
import 'package:evira_e_commerce/features/create_pin/ui/cubit/pin_cubit.dart'
    as _i734;
import 'package:evira_e_commerce/features/fill_profile/data/repos/fill_profile_repo_impl.dart'
    as _i133;
import 'package:evira_e_commerce/features/fill_profile/data/repos/image_picker_repo_impl.dart'
    as _i782;
import 'package:evira_e_commerce/features/fill_profile/domain/repos/fill_profile_repo.dart'
    as _i623;
import 'package:evira_e_commerce/features/fill_profile/domain/repos/image_picker_repo.dart'
    as _i1011;
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/fill_profile_usecase.dart'
    as _i1013;
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/image_picker_usecase.dart'
    as _i49;
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/recover_lost_image_usecase.dart'
    as _i419;
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/show_date_picker_usecase.dart'
    as _i494;
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/upload_profile_image_usecase.dart'
    as _i739;
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart'
    as _i179;
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/profile_image_cubit.dart'
    as _i378;
import 'package:evira_e_commerce/features/login/data/repos/login_repo_impl.dart'
    as _i1036;
import 'package:evira_e_commerce/features/login/domain/repos/login_repo.dart'
    as _i890;
import 'package:evira_e_commerce/features/login/domain/usecases/login_usecase.dart'
    as _i516;
import 'package:evira_e_commerce/features/login/ui/cubit/login_cubit.dart'
    as _i166;
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart'
    as _i672;
import 'package:evira_e_commerce/features/set_fingerprint/ui/cubit/fingerprint_cubit.dart'
    as _i418;
import 'package:evira_e_commerce/features/signup/data/repos/signup_repo_impl.dart'
    as _i280;
import 'package:evira_e_commerce/features/signup/domain/repos/signup_repo.dart'
    as _i962;
import 'package:evira_e_commerce/features/signup/domain/usecases/signup_usecase.dart'
    as _i109;
import 'package:evira_e_commerce/features/signup/ui/cubit/signup_cubit.dart'
    as _i630;
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart' as _i170;
import 'package:evira_e_commerce/shared/cubits/social_auth_cubit.dart' as _i149;
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
    gh.factory<_i418.FingerprintCubit>(() => _i418.FingerprintCubit());
    gh.factory<_i669.TextFieldCubit>(() => _i669.TextFieldCubit());
    gh.lazySingleton<_i858.BiometricsService>(() => _i858.BiometricsService());
    gh.lazySingleton<_i7.SharedPreferencesService>(
      () => _i7.SharedPreferencesService(),
    );
    gh.lazySingleton<_i769.SocialAuthService>(() => _i769.SocialAuthService());
    gh.lazySingleton<_i193.ThemeService>(() => _i193.ThemeService());
    gh.lazySingleton<_i101.ToastService>(() => _i101.ToastService());
    gh.lazySingleton<_i170.AppFlowCubit>(() => _i170.AppFlowCubit());
    gh.factory<_i149.SocialAuthCubit>(
      () => _i149.SocialAuthCubit(gh<_i769.SocialAuthService>()),
    );
    gh.lazySingleton<_i623.FillProfileRepo>(() => _i133.FillProfileRepoImpl());
    gh.lazySingleton<_i1030.CreatePinRepo>(() => _i825.CreatePinRepoImpl());
    gh.factory<_i820.GetThemeModeUseCase>(
      () => _i820.GetThemeModeUseCase(gh<_i193.ThemeService>()),
    );
    gh.factory<_i733.SetThemeModeUseCase>(
      () => _i733.SetThemeModeUseCase(gh<_i193.ThemeService>()),
    );
    gh.lazySingleton<_i1011.ImagePickerRepo>(() => _i782.ImagePickerRepoImpl());
    gh.lazySingleton<_i436.ThemeCubit>(
      () => _i436.ThemeCubit(
        gh<_i820.GetThemeModeUseCase>(),
        gh<_i733.SetThemeModeUseCase>(),
      ),
    );
    gh.lazySingleton<_i962.SignupRepo>(() => _i280.SignupRepoImpl());
    gh.lazySingleton<_i890.LoginRepo>(() => _i1036.LoginRepoImpl());
    gh.factory<_i49.ImagePickerUsecase>(
      () => _i49.ImagePickerUsecase(gh<_i1011.ImagePickerRepo>()),
    );
    gh.factory<_i419.RecoverLostImageUsecase>(
      () => _i419.RecoverLostImageUsecase(gh<_i1011.ImagePickerRepo>()),
    );
    gh.factory<_i419.SavePinUsecase>(
      () => _i419.SavePinUsecase(gh<_i1030.CreatePinRepo>()),
    );
    gh.factory<_i831.VerifyPinUsecase>(
      () => _i831.VerifyPinUsecase(gh<_i1030.CreatePinRepo>()),
    );
    gh.factory<_i1013.FillProfileUsecase>(
      () => _i1013.FillProfileUsecase(gh<_i623.FillProfileRepo>()),
    );
    gh.factory<_i739.UploadprofileimageUsecase>(
      () => _i739.UploadprofileimageUsecase(gh<_i623.FillProfileRepo>()),
    );
    gh.factory<_i494.ShowDatePickerUsecase>(
      () => _i494.ShowDatePickerUsecase(gh<_i623.FillProfileRepo>()),
    );
    gh.factory<_i109.SignupUsecase>(
      () => _i109.SignupUsecase(signupRepo: gh<_i962.SignupRepo>()),
    );
    gh.factory<_i734.PinCubit>(
      () => _i734.PinCubit(
        gh<_i419.SavePinUsecase>(),
        gh<_i831.VerifyPinUsecase>(),
      ),
    );
    gh.factory<_i516.LoginUsecase>(
      () => _i516.LoginUsecase(gh<_i890.LoginRepo>()),
    );
    gh.factory<_i378.ProfileImageCubit>(
      () => _i378.ProfileImageCubit(
        gh<_i49.ImagePickerUsecase>(),
        gh<_i419.RecoverLostImageUsecase>(),
      ),
    );
    gh.factory<_i179.FillProfileCubit>(
      () => _i179.FillProfileCubit(
        gh<_i494.ShowDatePickerUsecase>(),
        gh<_i1013.FillProfileUsecase>(),
        gh<_i739.UploadprofileimageUsecase>(),
      ),
    );
    gh.factory<_i166.LoginCubit>(
      () => _i166.LoginCubit(gh<_i516.LoginUsecase>()),
    );
    gh.factory<_i630.SignupCubit>(
      () => _i630.SignupCubit(gh<_i109.SignupUsecase>()),
    );
    return this;
  }
}
