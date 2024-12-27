import 'package:dio/dio.dart';
import 'package:tezda_cart/core/constants/urls.dart';

import 'app_service.dart';

class ProductService {
  BaseService service = BaseService();

  Future<List?> getProducts({int limit = 20, int skip = 0}) async {
    try {
      Response? response = await service.request(
        '${ApiUrls.getProducts}?limit=$limit&skip=$skip',
        method: "Get",
      );
      if (response != null) {
        return response.data['products'] ?? [];
      }
      return null;
    } on DioException catch (e) {
      throw handleError(e);
    }
  }
}
