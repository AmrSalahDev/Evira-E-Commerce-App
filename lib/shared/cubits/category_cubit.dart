import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/shared/domain/entities/category_entity.dart';
import 'package:evira_e_commerce/shared/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoryCubit(this.getCategoriesUseCase) : super(CategoryInitial());

  Future<void> loadCategories({int limit = 8}) async {
    emit(CategoryLoading());
    try {
      final categories = await getCategoriesUseCase(limit);
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
