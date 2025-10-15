import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/special_offers/domain/usecases/get_special_offers_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/special_offers/domain/entities/special_offer_entity.dart';
import 'package:injectable/injectable.dart';

part 'special_offers_event.dart';
part 'special_offers_state.dart';

@injectable
class SpecialOffersBloc extends Bloc<SpecialOffersEvent, SpecialOffersState> {
  final GetSpecialOffersUsecase getSpecialOffersUsecase;
  SpecialOffersBloc(this.getSpecialOffersUsecase)
    : super(SpecialOffersInitial()) {
    on<GetSpecialOffersEvent>((event, emit) async {
      emit(SpecialOffersLoading());
      await AppUtils.handleCode(
        code: () async {
          final specialOffers = await getSpecialOffersUsecase.call();

          emit(SpecialOffersLoaded(specialOffers));
        },
        onNoInternet: (message) {
          emit(SpecialOffersError(message));
        },
        onError: (message) {
          emit(SpecialOffersError(message));
        },
      );
    });
  }
}
