import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/category_view/domain/usecases/get_category_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/category_view/domain/entities/category_view_entity.dart';
import 'package:injectable/injectable.dart';

part 'category_view_event.dart';
part 'category_view_state.dart';

@injectable
class CategoryViewBloc extends Bloc<CategoryViewEvent, CategoryViewState> {
  final GetCategoryProductsUsecase getCategoryProductsUsecase;
  CategoryViewBloc(this.getCategoryProductsUsecase)
    : super(CategoryViewInitial()) {
    on<GetCategoryProductsEvent>(
      (event, emit) async {
        emit(CategoryViewLoading());
        await AppUtils.handleCode(
          code: () async {
            final products = await getCategoryProductsUsecase(event.categoryId);
            emit(CategoryViewLoaded(products));
          },
          onNoInternet: (message) => emit(CategoryViewError(message)),
          onError: (message) => emit(CategoryViewError(message)),
        );
      },
      transformer: droppable(),
    ); // Ignore extra refreshes while one is in progress
  }
}
