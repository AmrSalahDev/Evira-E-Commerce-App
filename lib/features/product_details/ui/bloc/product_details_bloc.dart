import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';
import 'package:evira_e_commerce/features/product_details/domain/usecases/get_product_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetailsUsecase getProductDetailsUsecase;
  ProductDetailsBloc(this.getProductDetailsUsecase)
    : super(ProductDetailsInitial()) {
    on<GetProductDetailsEvent>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          final productDetails = await getProductDetailsUsecase.call(
            event.productId,
          );
          if (productDetails != null) {
            emit(ProductDetailsLoaded(productDetails));
          }
        },
        onNoInternet: (message) => emit(ProductDetailsError(message)),
        onError: (message) => emit(ProductDetailsError(message)),
      );
    });
  }
}
