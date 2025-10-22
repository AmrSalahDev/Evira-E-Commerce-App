import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/search/domain/entities/filter_entity.dart';
import 'package:evira_e_commerce/features/search/domain/entities/result_products_entity.dart';
import 'package:evira_e_commerce/features/search/domain/usecases/apply_filters_usecase.dart';
import 'package:evira_e_commerce/features/search/domain/usecases/search_result_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'search_results_event.dart';
part 'search_results_state.dart';

@injectable
class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  final SearchResultUsecase searchResultUsecase;
  final ApplyFiltersUsecase applyFiltersUsecase;
  bool isSearchResult = false;
  SearchResultsBloc(this.searchResultUsecase, this.applyFiltersUsecase)
    : super(SearchResultsInitial()) {
    on<SearchResultEvent>((event, emit) async {
      if (event.keyword.trim().isEmpty) return;
      isSearchResult = true;
      emit(SearchResultLoading());
      await AppUtils.handleCode(
        code: () async {
          final products = await searchResultUsecase(event.keyword);
          emit(SearchResultLoaded(products: products));
        },
        onNoInternet: (message) => emit(SearchResultError(message: message)),
        onError: (message) {
          emit(SearchResultError(message: message));
        },
      );
    });

    on<ApplyFiltersEvent>((event, emit) async {
      if (event.keyword.trim().isEmpty) {
        emit(SearchResultError(message: EviraLang.current.pleaseEnterKeyword));
        return;
      }
      isSearchResult = true;
      emit(SearchResultLoading());
      await AppUtils.handleCode(
        code: () async {
          final products = await applyFiltersUsecase(
            event.filter,
            event.keyword,
          );
          emit(SearchResultLoaded(products: products));
        },
        onNoInternet: (message) => emit(SearchResultError(message: message)),
        onError: (message) {
          emit(SearchResultError(message: message));
        },
      );
    });
  }
}
