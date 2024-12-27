import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda_cart/core/widgets/snack_bar.dart';
import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  final pref = await SharedPreferences.getInstance();
  final String? currentUser = pref.getString('currentUser');
  String initialRoute = currentUser != null ? AppRouter.productList : AppRouter.login;

  runApp(ProviderScope(child: MyApp(initialRoute)));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppSnackBars.scaffoldMessengerKey,
      title: 'Product App',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: initialRoute,
    );
  }
}
