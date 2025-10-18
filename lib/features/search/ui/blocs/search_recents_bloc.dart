import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/notification/domain/usecases/clear_all_notificatons_usecase.dart';
import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:evira_e_commerce/features/search/domain/usecases/add_search_recent_keyword_usecase.dart';
import 'package:evira_e_commerce/features/search/domain/usecases/delete_recent_keyword_usecase.dart';
import 'package:evira_e_commerce/features/search/domain/usecases/get_recent_keywords_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_recents_event.dart';
part 'search_recents_state.dart';

EventTransformer<E> debounceEvent<E>(Duration duration) {
  //return (events, mapper) => events.debounce(duration).asyncExpand(mapper);

  // If your repository method hits an API, you can combine debounce with switchMap to automatically cancel previous API calls when a new keyword arrives.
  return (events, mapper) => events
      .debounce(duration)
      .switchMap(
        mapper,
      ); // This ensures: The user types fast → old searches get cancelled → Only the latest one runs
}

@injectable
class SearchRecentsBloc extends Bloc<SearchRecentsEvent, SearchRecentsState> {
  final AddSearchRecentKeywordUsecase addSearchRecentKeywordUsecase;
  final DeleteRecentKeywordUsecase deleteRecentKeywordUsecase;
  final ClearAllNotificatonsUsecase clearAllNotificatonsUsecase;
  final GetRecentKeywordsUsecase getRecentKeywordsUsecase;

  SearchRecentsBloc(
    this.addSearchRecentKeywordUsecase,
    this.deleteRecentKeywordUsecase,
    this.clearAllNotificatonsUsecase,
    this.getRecentKeywordsUsecase,
  ) : super(SearchRecentsInitial()) {
    on<AddRecentKeywordEvent>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          await addSearchRecentKeywordUsecase(event.keyword);
        },
        onNoInternet: (message) =>
            emit(SearchRecentKeywordsError(message: message)),
        onError: (message) => emit(SearchRecentKeywordsError(message: message)),
      );
    });

    on<DeleteRecentKeywordEvent>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          await deleteRecentKeywordUsecase(event.id);
          add(GetRecentKeywordsEvent(null));
        },
        onNoInternet: (message) =>
            emit(SearchRecentKeywordsError(message: message)),
        onError: (message) => emit(SearchRecentKeywordsError(message: message)),
      );
    });

    on<ClearAllRecentKeywordsEvent>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          await clearAllNotificatonsUsecase();
          add(GetRecentKeywordsEvent(null));
        },
        onNoInternet: (message) =>
            emit(SearchRecentKeywordsError(message: message)),
        onError: (message) => emit(SearchRecentKeywordsError(message: message)),
      );
    });

    on<GetRecentKeywordsEvent>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          final keywords = await getRecentKeywordsUsecase(event.keyword);
          emit(SearchRecentKeywordsLoaded(keywords: keywords));
        },
        onNoInternet: (message) =>
            emit(SearchRecentKeywordsError(message: message)),
        onError: (message) => emit(SearchRecentKeywordsError(message: message)),
      );
    }, transformer: debounceEvent(const Duration(milliseconds: 400)));
  }
}
