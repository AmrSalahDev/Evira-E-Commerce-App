import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/usecases/get_home_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_products_event.dart';
part 'home_products_state.dart';

@injectable
class HomeProductsBloc extends Bloc<HomeProductsEvent, HomeProductsState> {
  final GetHomeProductsUsecase getHomeProductsUsecase;

  HomeProductsBloc(this.getHomeProductsUsecase) : super(HomeProductsInitial()) {
    // First load (initial page or when switching category)
    on<LoadHomeProducts>((event, emit) async {
      emit(HomeProductsLoading());
      await AppUtils.handleCode(
        code: () async {
          final products = await getHomeProductsUsecase(
            categoryId: event.categoryId,
            limit: event.limit,
            page: event.page,
          );
          emit(
            HomeProductsLoaded(
              products: products,
              hasReachedEnd: products.isEmpty,
            ),
          );
        },
        onNoInternet: (message) {
          emit(HomeProductsError(message: message));
        },
        onError: (message) {
          emit(HomeProductsError(message: message));
        },
      );
    });

    //  Lazy load more (pagination)
    on<LoadMoreHomeProducts>((event, emit) async {
      final currentState = state;
      if (currentState is! HomeProductsLoaded) return;

      // Prevent loading again if already at end
      if (currentState.hasReachedEnd) return;

      final currentProducts = currentState.products;

      await AppUtils.handleCode(
        code: () async {
          final newProducts = await getHomeProductsUsecase(
            categoryId: event.categoryId,
            limit: event.limit,
            page: event.page,
          );

          emit(
            HomeProductsLoaded(
              products: [...currentProducts, ...newProducts],
              hasReachedEnd: newProducts.isEmpty,
            ),
          );
        },
        onNoInternet: (message) {
          emit(HomeProductsError(message: message));
        },
        onError: (message) {
          emit(HomeProductsError(message: message));
        },
      );
    });
  }
}
