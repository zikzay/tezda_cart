import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_cart/core/services/local_storage.dart';
import '../../product/domain/product_model.dart'; // Update the path if necessary

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]) {
    getFromStorage(); // Initialize state from storage when the provider is first created
  }

  void toggleFavorite(Product product) {
    if (state.contains(product.id)) {
      state = state.where((id) => id != product.id).toList();
    } else {
      List<int> newProducts = [...state, product.id ?? 0];
      state = newProducts;
    }
    LocalStorage.save('favorites', jsonEncode(state));
  }

  Future<void> getFromStorage() async {
    final List<int> jsonData = jsonDecode((await LocalStorage.get('favorites')) ?? '[]').cast<int>();
    state = jsonData;
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});
