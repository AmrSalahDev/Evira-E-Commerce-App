import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/most_popular/domain/entities/most_popular_entity.dart';
import 'package:evira_e_commerce/features/most_popular/domain/usecases/get_most_popular_by_category_usecase.dart';
import 'package:evira_e_commerce/features/most_popular/domain/usecases/get_most_popular_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'most_popular_event.dart';
part 'most_popular_state.dart';

@injectable
class MostPopularBloc extends Bloc<MostPopularEvent, MostPopularState> {
  final GetMostPopularUsecase getMostPopularUseCase;
  final GetMostPopularByCategoryUsecase getMostPopularByCategoryUseCase;
  MostPopularBloc(
    this.getMostPopularUseCase,
    this.getMostPopularByCategoryUseCase,
  ) : super(MostPopularInitial()) {
    on<GetMostPopularProducts>((event, emit) async {
      emit(MostPopularLoading());
      await AppUtils.handleCode(
        code: () async {
          if (isClosed) return;
          if (event.categoryId == 0) {
            final products = await getMostPopularUseCase.call();
            emit(MostPopularLoaded(products));
          } else {
            final products = await getMostPopularByCategoryUseCase.call(
              event.categoryId,
            );
            emit(MostPopularLoaded(products));
          }
        },
        onNoInternet: (message) {
          emit(MostPopularError(message));
        },
        onError: (message) {
          emit(MostPopularError(message));
        },
      );
    });
  }
}
