import 'package:tezda_cart/core/services/product_service.dart';

import '../../../core/services/app_service.dart';
import '../domain/product_model.dart';

class ProductRepository {
  final ProductService _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> getProducts({int page = 0}) async {
    final int limit = 20;
    final int skip = 20 * page;
    final productsData = await _apiService.getProducts(limit: limit, skip: skip);

    return productsData?.map<Product>((json) => Product.fromJson(json)).toList() ?? [];
  }
}
