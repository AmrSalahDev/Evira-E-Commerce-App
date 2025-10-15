import 'dart:async';

import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/wishlist/domain/usecases/get_wishlist_by_category_usecase.dart';
import 'package:evira_e_commerce/features/wishlist/domain/usecases/add_product_to_wishlist_usecase.dart';
import 'package:evira_e_commerce/features/wishlist/domain/usecases/get_products_from_wishlist_usecase.dart';
import 'package:evira_e_commerce/features/wishlist/domain/usecases/on_favorites_changes_usecase.dart';
import 'package:evira_e_commerce/features/wishlist/domain/usecases/remove_product_from_wishlist_usecase.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

@injectable
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final RemoveProductFromWishlistUsecase removeProductFromWishlistUsecase;
  final AddProductToWishlistUsecase addProductToWishlistUsecase;
  final GetProductsFromWishlistUsecase getProductsFromWishlistUsecase;
  final GetWishlistByCategoryUsecase getWishlistByCategoryUsecase;
  final OnFavoritesChangesUsecase onFavoritesChangesUsecase;
  StreamSubscription? _sub;

  WishlistBloc(
    this.removeProductFromWishlistUsecase,
    this.addProductToWishlistUsecase,
    this.getProductsFromWishlistUsecase,
    this.getWishlistByCategoryUsecase,
    this.onFavoritesChangesUsecase,
  ) : super(WishlistInitial()) {
    on<AddProductToWishlist>((event, emit) async {
      debugPrint("AddProductToWishlist");
      await AppUtils.handleCode(
        code: () async {
          await addProductToWishlistUsecase.call(event.productId);
          add(GetProductsFromWishlist());
        },
        onNoInternet: (message) {
          emit(WishlistError(message: message));
        },
        onError: (message) {
          emit(WishlistError(message: message));
        },
      );
    });
    on<RemoveProductFromWishlist>((event, emit) async {
      debugPrint("RemoveProductFromWishlist");
      await AppUtils.handleCode(
        code: () async {
          await removeProductFromWishlistUsecase.call(event.productId);
          add(GetProductsFromWishlist());
        },
        onNoInternet: (message) {
          emit(WishlistError(message: message));
        },
        onError: (message) {
          emit(WishlistError(message: message));
        },
      );
    });
    on<GetProductsFromWishlist>((event, emit) async {
      debugPrint("GetProductsFromWishlist");
      emit(WishlistLoading());
      await AppUtils.handleCode(
        code: () async {
          final wishlist = await getProductsFromWishlistUsecase.call();
          emit(WishlistLoaded(wishlistProducts: wishlist));
        },
        onNoInternet: (message) {
          emit(WishlistError(message: message));
        },
        onError: (message) {
          emit(WishlistError(message: message));
        },
      );
    });

    on<GetProductsFromWishlistByCategory>((event, emit) async {
      debugPrint("GetProductsFromWishlistByCategory");
      emit(WishlistLoading());
      await AppUtils.handleCode(
        code: () async {
          final wishlist = await getWishlistByCategoryUsecase.call(
            event.categoryId,
          );

          emit(WishlistLoaded(wishlistProducts: wishlist));
        },
        onNoInternet: (message) {
          emit(WishlistError(message: message));
        },
        onError: (message) {
          emit(WishlistError(message: message));
        },
      );
    });
    on<OnFavoritesChanges>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          add(GetProductsFromWishlist());
          await _sub?.cancel();
          _sub = onFavoritesChangesUsecase.call().listen((_) async {
            debugPrint("OnFavoritesChanges");
            add(GetProductsFromWishlist());
          });
        },
        onNoInternet: (message) {
          emit(WishlistError(message: message));
        },
        onError: (message) {
          emit(WishlistError(message: message));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
