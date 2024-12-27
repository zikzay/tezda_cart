import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tezda_cart/core/constants/urls.dart';
import 'package:tezda_cart/core/services/local_storage.dart';
import 'package:tezda_cart/core/services/logger.dart';
import 'package:tezda_cart/core/widgets/snack_bar.dart';

class ApiService {
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}

class BaseService {
  //Dio instance or Object
  final Dio _dio = Dio(BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      },
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000)))
    ..interceptors.add(LoggingInterceptor());

  //function that sends a request (on a soft)
  Future<Response?> request(String url, {dynamic body, required String method}) async {
    var token = await LocalStorage.getToken();

    Response response = await _dio.request(url,
        data: body,
        options: Options(method: method, headers: token != null ? {'authorization': 'Bearer $token'} : null));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    }

    AppSnackBars.error(message: response.data['message'] ?? 'Something went wrong');

    return null;
  }
}

//function that handles Dio's API calls errors pertaining to internet connection
dynamic handleError(DioException error) {
  if (error.message!.contains('SocketException')) {
    return AppSnackBars.noInternet(
      message: 'We cannot detect internet connection. Seems like you are offline.',
      message2: 'Please retry.',
    );
  }

  if (error.type == DioExceptionType.connectionTimeout) {
    return AppSnackBars.noInternet(
      message: 'Connection timed out. Seems like you are offline.',
      message2: 'Please retry.',
    );
  }

  if (error.response == null || error.response?.data is String) {
    return AppSnackBars.noInternet(
      message: 'Something went wrong.',
      message2: 'Please try again later',
    );
  }
  return AppSnackBars.noInternet(message: 'Something went wrong.', message2: 'Please try again later');
}
