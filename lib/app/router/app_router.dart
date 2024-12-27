import 'package:flutter/material.dart';
import 'package:tezda_cart/features/product/domain/product_model.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/registration_screen.dart';
import '../../features/product/presentation/product_list_screen.dart';
import '../../features/product/presentation/product_detail_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';

class AppRouter {
  static const String productList = '/';
  static const String productDetail = '/product-detail';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productList:
        return MaterialPageRoute(builder: (_) => ProductListScreen());
      case productDetail:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Unknown route'))),
        );
    }
  }
}
