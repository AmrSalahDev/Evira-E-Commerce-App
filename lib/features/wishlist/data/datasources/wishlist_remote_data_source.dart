import 'dart:async';

import 'package:evira_e_commerce/shared/data/models/product_model.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class WishlistRemoteDataSource {
  Future<void> addProductToWishlist(int productId);
  Future<void> removeProductFromWishlist(int productId);
  Future<void> toggleFavorite(int productId, bool isFavorite);
  Future<List<ProductEntity>> getWishlistProducts();
  Future<List<ProductEntity>> getWishlistProductsByCategory(int categoryId);
  Future<bool> isProductInWishlist(int productId);
  Stream<void> onFavoritesChanged();
}

@LazySingleton(as: WishlistRemoteDataSource)
class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final client = Supabase.instance.client;
  static const tableName = 'favorites';

  @override
  Future<void> addProductToWishlist(int productId) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;
    await client.from(tableName).insert({
      'user_id': userId,
      'product_id': productId,
    });
  }

  @override
  Future<void> removeProductFromWishlist(int productId) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;
    await client.from(tableName).delete().match({
      'user_id': userId,
      'product_id': productId,
    });
  }

  @override
  Future<void> toggleFavorite(int productId, bool isFavorite) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;
    if (isFavorite) {
      await client.from(tableName).delete().match({
        'user_id': userId,
        'product_id': productId,
      });
    } else {
      await client.from(tableName).insert({
        'user_id': userId,
        'product_id': productId,
      });
    }
  }

  @override
  Future<List<ProductEntity>> getWishlistProducts() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return [];

    // Select products that are in the user's favorites
    final res = await client
        .from(tableName) // Select from favorites table
        .select(
          'products(*, favorites!left(user_id))',
        ) // Join products table and favorites table on user_id
        .eq('user_id', userId) // Filter by user_id
        .order('created_at', ascending: false); // Order by created_at

    if (res.isEmpty) return []; // If no favorites, return empty list

    // Extract the nested 'products' object for each favorite
    final List products = res
        .map((item) => item['products']) // Get the 'products' object
        .where((p) => p != null) // Filter out null values
        .toList();

    return products
        .map((e) => ProductModel.fromJson(e, userId).toEntity())
        .toList();
  }

  @override
  Future<List<ProductEntity>> getWishlistProductsByCategory(
    int categoryId,
  ) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return [];

    final res = await client
        .from(tableName)
        .select('products(*, favorites!left(user_id))') // Join products table
        .match({
          'user_id': userId,
          'products.category_id': categoryId,
        }) // Filter by user_id and category_id
        .order('created_at', ascending: false); // Order by created_at

    if (res.isEmpty) return [];

    final products = res
        .map((item) => item['products'])
        .where((p) => p != null)
        .toList();

    return products
        .map((e) => ProductModel.fromJson(e, userId).toEntity())
        .toList();
  }

  @override
  Future<bool> isProductInWishlist(int productId) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return false;

    final response = await Supabase.instance.client
        .from(tableName)
        .select('id')
        .match({'user_id': user.id, 'product_id': productId})
        .maybeSingle();

    return response != null;
  }

  @override
  Stream<void> onFavoritesChanged() {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return const Stream.empty();

    final controller = StreamController<void>.broadcast();
    final channel = client.channel('favorites-channel');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: tableName,
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: userId,
      ),
      callback: (payload) {
        controller.add(null); // notify cubit
      },
    );

    channel.subscribe();

    controller.onCancel = () async {
      await channel.unsubscribe();
    };

    return controller.stream;
  }
}
