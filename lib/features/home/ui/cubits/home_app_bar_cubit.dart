import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_app_bar_entity.dart';
import 'package:evira_e_commerce/features/home/domain/usecases/get_user_info_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'home_app_bar_state.dart';

@injectable
class HomeAppBarCubit extends Cubit<HomeAppBarState> {
  final GetUserInfoUsecase getUserInfoUsecase;
  HomeAppBarCubit(this.getUserInfoUsecase) : super(const HomeAppBarState());

  void loadUserInfo() {
    emit(state.copyWith(isLoading: true));
    try {
      final data = getUserInfoUsecase.call();
      emit(state.copyWith(data: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
