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
import 'package:evira_e_commerce/features/home/data/repos/home_app_bar_repo_impl.dart'
    as _i603;
import 'package:evira_e_commerce/features/home/data/repos/home_banner_repo_impl.dart'
    as _i170;
import 'package:evira_e_commerce/features/home/data/repos/home_product_repo_impl.dart'
    as _i99;
import 'package:evira_e_commerce/features/home/domain/repos/home_app_bar_repo.dart'
    as _i771;
import 'package:evira_e_commerce/features/home/domain/repos/home_banner_repo.dart'
    as _i487;
import 'package:evira_e_commerce/features/home/domain/repos/home_product_repo.dart'
    as _i424;
import 'package:evira_e_commerce/features/home/domain/usecases/get_all_products_usecase.dart'
    as _i350;
import 'package:evira_e_commerce/features/home/domain/usecases/get_home_banners_usecase.dart'
    as _i167;
import 'package:evira_e_commerce/features/home/domain/usecases/get_products_by_category_id_usecase.dart'
    as _i685;
import 'package:evira_e_commerce/features/home/domain/usecases/get_user_info_usecase.dart'
    as _i965;
import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart'
    as _i329;
import 'package:evira_e_commerce/features/home/ui/cubits/home_banner_cubit.dart'
    as _i1000;
import 'package:evira_e_commerce/features/home/ui/cubits/home_product_cubit.dart'
    as _i385;
import 'package:evira_e_commerce/features/login/data/repos/login_repo_impl.dart'
    as _i1036;
import 'package:evira_e_commerce/features/login/domain/repos/login_repo.dart'
    as _i890;
import 'package:evira_e_commerce/features/login/domain/usecases/login_usecase.dart'
    as _i516;
import 'package:evira_e_commerce/features/login/ui/cubit/login_cubit.dart'
    as _i166;
import 'package:evira_e_commerce/features/most_popular/data/datasources/most_popular_remote_datasource_impl.dart'
    as _i1056;
import 'package:evira_e_commerce/features/most_popular/data/repos/most_popular_repo_impl.dart'
    as _i299;
import 'package:evira_e_commerce/features/most_popular/domain/datasources/most_popular_remote_datasource.dart'
    as _i369;
import 'package:evira_e_commerce/features/most_popular/domain/repos/most_popular_repo.dart'
    as _i815;
import 'package:evira_e_commerce/features/most_popular/domain/usecases/get_most_popular_by_category_usecase.dart'
    as _i190;
import 'package:evira_e_commerce/features/most_popular/domain/usecases/get_most_popular_usecase.dart'
    as _i583;
import 'package:evira_e_commerce/features/most_popular/ui/bloc/most_popular_bloc.dart'
    as _i472;
import 'package:evira_e_commerce/features/notification/data/datasources/notification_remote_data_source.dart'
    as _i251;
import 'package:evira_e_commerce/features/notification/data/repo/notification_repo_impl.dart'
    as _i583;
import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart'
    as _i305;
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart'
    as _i306;
import 'package:evira_e_commerce/features/notification/domain/usecases/clear_all_notificatons_usecase.dart'
    as _i289;
import 'package:evira_e_commerce/features/notification/domain/usecases/delete_notification_usecase.dart'
    as _i819;
import 'package:evira_e_commerce/features/notification/domain/usecases/get_notifications_usecase.dart'
    as _i168;
import 'package:evira_e_commerce/features/notification/domain/usecases/get_unseen_notifications_count_usecase.dart'
    as _i29;
import 'package:evira_e_commerce/features/notification/domain/usecases/listen_notifications_changes_usecase.dart'
    as _i302;
import 'package:evira_e_commerce/features/notification/domain/usecases/mark_notifications_as_seen_usecase.dart'
    as _i629;
import 'package:evira_e_commerce/features/notification/ui/bloc/notification_bloc.dart'
    as _i529;
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart'
    as _i672;
import 'package:evira_e_commerce/features/search/data/datasources/search_remote_datasource_impl.dart'
    as _i758;
import 'package:evira_e_commerce/features/search/data/repos/search_repo_impl.dart'
    as _i388;
import 'package:evira_e_commerce/features/search/domain/datasources/search_remote_datasource.dart'
    as _i675;
import 'package:evira_e_commerce/features/search/domain/repos/search_repo.dart'
    as _i595;
import 'package:evira_e_commerce/features/search/domain/usecases/add_search_recent_keyword_usecase.dart'
    as _i299;
import 'package:evira_e_commerce/features/search/domain/usecases/clear_all_recent_keywords_usecase.dart'
    as _i615;
import 'package:evira_e_commerce/features/search/domain/usecases/delete_recent_keyword_usecase.dart'
    as _i1018;
import 'package:evira_e_commerce/features/search/domain/usecases/get_recent_keywords_usecase.dart'
    as _i812;
import 'package:evira_e_commerce/features/search/domain/usecases/search_result_usecase.dart'
    as _i570;
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart'
    as _i1071;
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart'
    as _i738;
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
import 'package:evira_e_commerce/features/special_offers/data/datasources/special_offers_datasource_impl.dart'
    as _i1045;
import 'package:evira_e_commerce/features/special_offers/data/repos/special_offers_repo_impl.dart'
    as _i752;
import 'package:evira_e_commerce/features/special_offers/domain/datasources/special_offers_datasource.dart'
    as _i64;
import 'package:evira_e_commerce/features/special_offers/domain/repos/specail_offers_repo.dart'
    as _i563;
import 'package:evira_e_commerce/features/special_offers/domain/usecases/get_special_offers_usecase.dart'
    as _i1018;
import 'package:evira_e_commerce/features/special_offers/ui/bloc/special_offers_bloc.dart'
    as _i546;
import 'package:evira_e_commerce/features/wishlist/data/datasources/wishlist_remote_data_source.dart'
    as _i307;
import 'package:evira_e_commerce/features/wishlist/data/repos/wishlist_repo_impl.dart'
    as _i540;
import 'package:evira_e_commerce/features/wishlist/domain/repos/wishlist_repo.dart'
    as _i603;
import 'package:evira_e_commerce/features/wishlist/domain/services/wishlist_service.dart'
    as _i754;
import 'package:evira_e_commerce/features/wishlist/domain/usecases/add_product_to_wishlist_usecase.dart'
    as _i590;
import 'package:evira_e_commerce/features/wishlist/domain/usecases/get_products_from_wishlist_usecase.dart'
    as _i940;
import 'package:evira_e_commerce/features/wishlist/domain/usecases/get_wishlist_by_category_usecase.dart'
    as _i591;
import 'package:evira_e_commerce/features/wishlist/domain/usecases/on_favorites_changes_usecase.dart'
    as _i524;
import 'package:evira_e_commerce/features/wishlist/domain/usecases/remove_product_from_wishlist_usecase.dart'
    as _i80;
import 'package:evira_e_commerce/features/wishlist/ui/bloc/wishlist_bloc.dart'
    as _i218;
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart' as _i170;
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart' as _i296;
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart' as _i795;
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart' as _i969;
import 'package:evira_e_commerce/shared/cubits/social_auth_cubit.dart' as _i149;
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart' as _i669;
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart' as _i436;
import 'package:evira_e_commerce/shared/data/repos/category_repo_impl.dart'
    as _i1010;
import 'package:evira_e_commerce/shared/domain/repos/category_repo.dart'
    as _i457;
import 'package:evira_e_commerce/shared/domain/usecases/get_categories_usecase.dart'
    as _i790;
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
    gh.lazySingleton<_i101.ToastService>(() => _i101.ToastService());
    gh.lazySingleton<_i170.AppFlowCubit>(() => _i170.AppFlowCubit());
    gh.lazySingleton<_i795.GreetingCubit>(() => _i795.GreetingCubit());
    gh.lazySingleton<_i969.NetworkCubit>(() => _i969.NetworkCubit());
    gh.lazySingleton<_i436.ThemeCubit>(() => _i436.ThemeCubit());
    gh.factory<_i149.SocialAuthCubit>(
      () => _i149.SocialAuthCubit(gh<_i769.SocialAuthService>()),
    );
    gh.lazySingleton<_i307.WishlistRemoteDataSource>(
      () => _i307.WishlistRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i623.FillProfileRepo>(() => _i133.FillProfileRepoImpl());
    gh.lazySingleton<_i771.HomeAppBarRepo>(() => _i603.HomeAppBarRepoImpl());
    gh.lazySingleton<_i487.HomeBannerRepo>(() => _i170.HomeBannerRepoImpl());
    gh.lazySingleton<_i369.MostPopularRemoteDatasource>(
      () => _i1056.MostPopularRemoteDatasourceImpl(),
    );
    gh.lazySingleton<_i1030.CreatePinRepo>(() => _i825.CreatePinRepoImpl());
    gh.lazySingleton<_i64.SpecialOffersDatasource>(
      () => _i1045.SpecialOffersDatasourceImpl(),
    );
    gh.lazySingleton<_i563.SpecialOffersRepo>(
      () => _i752.SpecialOffersRepoImpl(gh<_i64.SpecialOffersDatasource>()),
    );
    gh.lazySingleton<_i424.HomeProductRepo>(() => _i99.HomeProductRepoImpl());
    gh.lazySingleton<_i1011.ImagePickerRepo>(() => _i782.ImagePickerRepoImpl());
    gh.lazySingleton<_i962.SignupRepo>(() => _i280.SignupRepoImpl());
    gh.lazySingleton<_i890.LoginRepo>(() => _i1036.LoginRepoImpl());
    gh.factory<_i49.ImagePickerUsecase>(
      () => _i49.ImagePickerUsecase(gh<_i1011.ImagePickerRepo>()),
    );
    gh.factory<_i419.RecoverLostImageUsecase>(
      () => _i419.RecoverLostImageUsecase(gh<_i1011.ImagePickerRepo>()),
    );
    gh.lazySingleton<_i251.NotificationRemoteDataSource>(
      () => _i251.NotificationRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i675.SearchRemoteDatasource>(
      () => _i758.SearchRemoteDatasourceImpl(),
    );
    gh.lazySingleton<_i457.CategoryRepo>(() => _i1010.CategoryRepoImpl());
    gh.lazySingleton<_i815.MostPopularRepo>(
      () => _i299.MostPopularRepoImpl(gh<_i369.MostPopularRemoteDatasource>()),
    );
    gh.factory<_i350.GetAllProductsUsecase>(
      () => _i350.GetAllProductsUsecase(gh<_i424.HomeProductRepo>()),
    );
    gh.factory<_i685.GetProductsByCategoryIdUsecase>(
      () => _i685.GetProductsByCategoryIdUsecase(gh<_i424.HomeProductRepo>()),
    );
    gh.lazySingleton<_i603.WishlistRepo>(
      () => _i540.WishlistRepoImpl(gh<_i307.WishlistRemoteDataSource>()),
    );
    gh.factory<_i167.GetHomeBannersUseCase>(
      () => _i167.GetHomeBannersUseCase(gh<_i487.HomeBannerRepo>()),
    );
    gh.factory<_i965.GetUserInfoUsecase>(
      () => _i965.GetUserInfoUsecase(gh<_i771.HomeAppBarRepo>()),
    );
    gh.factory<_i419.SavePinUsecase>(
      () => _i419.SavePinUsecase(gh<_i1030.CreatePinRepo>()),
    );
    gh.factory<_i831.VerifyPinUsecase>(
      () => _i831.VerifyPinUsecase(gh<_i1030.CreatePinRepo>()),
    );
    gh.factory<_i1000.HomeBannerCubit>(
      () => _i1000.HomeBannerCubit(gh<_i167.GetHomeBannersUseCase>()),
    );
    gh.lazySingleton<_i754.WishlistService>(
      () => _i754.WishlistService(gh<_i307.WishlistRemoteDataSource>()),
    );
    gh.factory<_i1013.FillProfileUsecase>(
      () => _i1013.FillProfileUsecase(gh<_i623.FillProfileRepo>()),
    );
    gh.factory<_i739.UploadprofileimageUsecase>(
      () => _i739.UploadprofileimageUsecase(gh<_i623.FillProfileRepo>()),
    );
    gh.factory<_i1018.GetSpecialOffersUsecase>(
      () => _i1018.GetSpecialOffersUsecase(
        specialOffersRepo: gh<_i563.SpecialOffersRepo>(),
      ),
    );
    gh.factory<_i494.ShowDatePickerUsecase>(
      () => _i494.ShowDatePickerUsecase(gh<_i623.FillProfileRepo>()),
    );
    gh.factory<_i590.AddProductToWishlistUsecase>(
      () => _i590.AddProductToWishlistUsecase(
        wishlistRepo: gh<_i603.WishlistRepo>(),
      ),
    );
    gh.factory<_i591.GetWishlistByCategoryUsecase>(
      () => _i591.GetWishlistByCategoryUsecase(
        wishlistRepo: gh<_i603.WishlistRepo>(),
      ),
    );
    gh.factory<_i80.RemoveProductFromWishlistUsecase>(
      () => _i80.RemoveProductFromWishlistUsecase(
        wishlistRepo: gh<_i603.WishlistRepo>(),
      ),
    );
    gh.factory<_i109.SignupUsecase>(
      () => _i109.SignupUsecase(signupRepo: gh<_i962.SignupRepo>()),
    );
    gh.factory<_i329.HomeAppBarCubit>(
      () => _i329.HomeAppBarCubit(gh<_i965.GetUserInfoUsecase>()),
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
    gh.factory<_i546.SpecialOffersBloc>(
      () => _i546.SpecialOffersBloc(gh<_i1018.GetSpecialOffersUsecase>()),
    );
    gh.factory<_i940.GetProductsFromWishlistUsecase>(
      () => _i940.GetProductsFromWishlistUsecase(gh<_i603.WishlistRepo>()),
    );
    gh.factory<_i524.OnFavoritesChangesUsecase>(
      () => _i524.OnFavoritesChangesUsecase(gh<_i603.WishlistRepo>()),
    );
    gh.lazySingleton<_i595.SearchRepo>(
      () => _i388.SearchRepoImpl(gh<_i675.SearchRemoteDatasource>()),
    );
    gh.factory<_i378.ProfileImageCubit>(
      () => _i378.ProfileImageCubit(
        gh<_i49.ImagePickerUsecase>(),
        gh<_i419.RecoverLostImageUsecase>(),
      ),
    );
    gh.factory<_i190.GetMostPopularByCategoryUsecase>(
      () => _i190.GetMostPopularByCategoryUsecase(gh<_i815.MostPopularRepo>()),
    );
    gh.factory<_i583.GetMostPopularUsecase>(
      () => _i583.GetMostPopularUsecase(gh<_i815.MostPopularRepo>()),
    );
    gh.lazySingleton<_i306.NotificationService>(
      () => _i306.NotificationService(gh<_i251.NotificationRemoteDataSource>()),
    );
    gh.factory<_i179.FillProfileCubit>(
      () => _i179.FillProfileCubit(
        gh<_i494.ShowDatePickerUsecase>(),
        gh<_i1013.FillProfileUsecase>(),
        gh<_i739.UploadprofileimageUsecase>(),
      ),
    );
    gh.factory<_i790.GetCategoriesUseCase>(
      () => _i790.GetCategoriesUseCase(gh<_i457.CategoryRepo>()),
    );
    gh.factory<_i166.LoginCubit>(
      () => _i166.LoginCubit(gh<_i516.LoginUsecase>()),
    );
    gh.lazySingleton<_i305.NotificationRepo>(
      () =>
          _i583.NotificationRepoImpl(gh<_i251.NotificationRemoteDataSource>()),
    );
    gh.factory<_i385.HomeProductCubit>(
      () => _i385.HomeProductCubit(
        gh<_i685.GetProductsByCategoryIdUsecase>(),
        gh<_i350.GetAllProductsUsecase>(),
      ),
    );
    gh.factory<_i299.AddSearchRecentKeywordUsecase>(
      () => _i299.AddSearchRecentKeywordUsecase(gh<_i595.SearchRepo>()),
    );
    gh.factory<_i615.ClearAllRecentKeywordsUsecase>(
      () => _i615.ClearAllRecentKeywordsUsecase(gh<_i595.SearchRepo>()),
    );
    gh.factory<_i1018.DeleteRecentKeywordUsecase>(
      () => _i1018.DeleteRecentKeywordUsecase(gh<_i595.SearchRepo>()),
    );
    gh.factory<_i812.GetRecentKeywordsUsecase>(
      () => _i812.GetRecentKeywordsUsecase(gh<_i595.SearchRepo>()),
    );
    gh.factory<_i570.SearchResultUsecase>(
      () => _i570.SearchResultUsecase(gh<_i595.SearchRepo>()),
    );
    gh.factory<_i296.CategoryCubit>(
      () => _i296.CategoryCubit(gh<_i790.GetCategoriesUseCase>()),
    );
    gh.factory<_i819.DeleteNotificationUsecase>(
      () => _i819.DeleteNotificationUsecase(
        notificationRepo: gh<_i305.NotificationRepo>(),
      ),
    );
    gh.factory<_i29.GetUnseenNotificationsCountUseCase>(
      () =>
          _i29.GetUnseenNotificationsCountUseCase(gh<_i305.NotificationRepo>()),
    );
    gh.factory<_i302.ListenNotificationsChangesUsecase>(
      () =>
          _i302.ListenNotificationsChangesUsecase(gh<_i305.NotificationRepo>()),
    );
    gh.factory<_i629.MarkNotificationsAsSeenUsecase>(
      () => _i629.MarkNotificationsAsSeenUsecase(gh<_i305.NotificationRepo>()),
    );
    gh.factory<_i472.MostPopularBloc>(
      () => _i472.MostPopularBloc(
        gh<_i583.GetMostPopularUsecase>(),
        gh<_i190.GetMostPopularByCategoryUsecase>(),
      ),
    );
    gh.factory<_i218.WishlistBloc>(
      () => _i218.WishlistBloc(
        gh<_i80.RemoveProductFromWishlistUsecase>(),
        gh<_i590.AddProductToWishlistUsecase>(),
        gh<_i940.GetProductsFromWishlistUsecase>(),
        gh<_i591.GetWishlistByCategoryUsecase>(),
        gh<_i524.OnFavoritesChangesUsecase>(),
      ),
    );
    gh.factory<_i738.SearchResultsBloc>(
      () => _i738.SearchResultsBloc(gh<_i570.SearchResultUsecase>()),
    );
    gh.factory<_i168.GetNotificationsUsecase>(
      () => _i168.GetNotificationsUsecase(gh<_i305.NotificationRepo>()),
    );
    gh.factory<_i630.SignupCubit>(
      () => _i630.SignupCubit(gh<_i109.SignupUsecase>()),
    );
    gh.factory<_i289.ClearAllNotificatonsUsecase>(
      () => _i289.ClearAllNotificatonsUsecase(gh<_i305.NotificationRepo>()),
    );
    gh.lazySingleton<_i529.NotificationBloc>(
      () => _i529.NotificationBloc(
        gh<_i306.NotificationService>(),
        gh<_i168.GetNotificationsUsecase>(),
        gh<_i289.ClearAllNotificatonsUsecase>(),
        gh<_i629.MarkNotificationsAsSeenUsecase>(),
        gh<_i29.GetUnseenNotificationsCountUseCase>(),
        gh<_i302.ListenNotificationsChangesUsecase>(),
        gh<_i819.DeleteNotificationUsecase>(),
      ),
    );
    gh.factory<_i1071.SearchRecentsBloc>(
      () => _i1071.SearchRecentsBloc(
        gh<_i299.AddSearchRecentKeywordUsecase>(),
        gh<_i1018.DeleteRecentKeywordUsecase>(),
        gh<_i289.ClearAllNotificatonsUsecase>(),
        gh<_i812.GetRecentKeywordsUsecase>(),
      ),
    );
    return this;
  }
}
