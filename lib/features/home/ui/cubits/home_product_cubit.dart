import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_product_entity.dart';
import 'package:evira_e_commerce/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:evira_e_commerce/features/home/domain/usecases/get_products_by_category_id_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_product_state.dart';

@injectable
class HomeProductCubit extends Cubit<HomeProductState> {
  final GetProductsByCategoryIdUsecase getProductsByCategoryIdUsecase;
  final GetAllProductsUsecase getAllProductsUsecase;
  HomeProductCubit(
    this.getProductsByCategoryIdUsecase,
    this.getAllProductsUsecase,
  ) : super(HomeProductInitial());

  Future<void> getProductsByCategoryId({
    required int categoryId,
    required String userId,
  }) async {
    emit(HomeProductLoading());
    try {
      final products = await getProductsByCategoryIdUsecase.call(
        categoryId,
        userId,
      );
      emit(HomeProductLoaded(products));
    } catch (e) {
      emit(HomeProductError(e.toString()));
    }
  }

  Future<void> loadAllProducts(String userId) async {
    emit(HomeProductLoading());
    try {
      final products = await getAllProductsUsecase.call(userId);
      emit(HomeProductLoaded(products));
    } catch (e) {
      emit(HomeProductError(e.toString()));
    }
  }
}
