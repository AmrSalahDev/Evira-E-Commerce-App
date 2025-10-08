import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_banner_entity.dart';
import 'package:evira_e_commerce/features/home/domain/usecases/get_home_banners_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_banner_state.dart';

@injectable
class HomeBannerCubit extends Cubit<HomeBannerState> {
  final GetHomeBannersUseCase getHomeBannersUseCase;
  HomeBannerCubit(this.getHomeBannersUseCase) : super(HomeBannerInitial());

  Future<void> loadBanners({int limit = 5}) async {
    emit(HomeBannerLoading());
    try {
      final banners = await getHomeBannersUseCase(limit);
      emit(HomeBannerLoaded(banners));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }
}
