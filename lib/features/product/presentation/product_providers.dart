import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_cart/core/services/product_service.dart';
import '../data/product_repository.dart';
import '../domain/product_model.dart';

// Service provider
final apiServiceProvider = Provider((ref) => ProductService());

// Repository provider
final productRepositoryProvider = Provider(
  (ref) => ProductRepository(ref.read(apiServiceProvider)),
);

// Product list state
class ProductListState {
  final List<Product> products;
  final bool isLoadingMore;
  final bool hasMore;

  ProductListState({
    required this.products,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  ProductListState copyWith({
    List<Product>? products,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// Product list notifier
class ProductListNotifier extends StateNotifier<ProductListState> {
  final ProductRepository _repository;
  int _page = 0;
  bool _isFetching = false; // Add a flag to track fetching state

  ProductListNotifier(this._repository) : super(ProductListState(products: []));

  int get currentPage => _page; // Getter for the current page

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (_isFetching) return; // Prevent multiple concurrent fetches

    _isFetching = true; // Set fetching flag to true

    // Increment the page if loading more
    final int page = !loadMore || state.products.isEmpty ? 0 : _page;

    if (loadMore) {
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final newProducts = await _repository.getProducts(page: page);

      // Increment the page if products are successfully loaded
      if (loadMore || newProducts.isNotEmpty) {
        _page++;
      }

      state = state.copyWith(
        products: [...state.products, ...newProducts],
        isLoadingMore: false,
        hasMore: newProducts.isNotEmpty,
      );
    } catch (error) {
      state = state.copyWith(isLoadingMore: false);
    }

    _isFetching = false; // Reset fetching flag
  }
}

// Product list provider
final productListProvider = StateNotifierProvider<ProductListNotifier, ProductListState>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return ProductListNotifier(repository)..fetchProducts();
});
