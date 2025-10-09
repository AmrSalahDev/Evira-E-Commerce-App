import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/home/domain/entities/home_category_entity.dart';
import 'package:evira_e_commerce/features/home/domain/usecases/get_home_categories_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_category_state.dart';

@injectable
class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  final GetHomeCategoriesUseCase getHomeCategoriesUseCase;
  HomeCategoryCubit(this.getHomeCategoriesUseCase)
    : super(HomeCategoryInitial());

  Future<void> loadCategories({int limit = 8}) async {
    emit(HomeCategoryLoading());
    try {
      final categories = await getHomeCategoriesUseCase(limit);
      emit(HomeCategoryLoaded(categories));
    } catch (e) {
      emit(HomeCategoryError(e.toString()));
    }
  }
}
