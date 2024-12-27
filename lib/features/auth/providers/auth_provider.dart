import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_cart/core/models/user.dart';
import 'package:tezda_cart/core/services/auth_service.dart';
import 'package:tezda_cart/core/services/local_storage.dart';
import 'package:tezda_cart/core/widgets/snack_bar.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  String? _currentUserEmail;
  final Map<String, String> _userProfiles = {};

  Future<bool> login({required String email, required String password}) async {
    try {
      AuthService service = AuthService();

      User? user = await service.login(email, password);

      return user != null;
    } catch (err) {
      AppSnackBars.error(message: 'Something went wrong');
      return false;
    }
  }

  Future<bool> register({required String email, required String password}) async {
    try {
      AuthService service = AuthService();

      var res = await service.register(email, password);

      return res != null;
    } catch (err) {
      AppSnackBars.error(message: 'Something went wrong 0');
      return false;
    }
  }

  Future<bool?> logout() async {
    AuthService service = AuthService();
    return await service.logout();
  }

  Future<User?> getUserInfo() async {
    AuthService service = AuthService();

    return await service.getUserInfo();
  }

  Future<void> updateUserInfo({
    required String firstName,
    required String lastName,
    required String? image,
  }) async {
    AuthService service = AuthService();

    await service.updateUserInfo(firstName: firstName, lastName: lastName, image: image);

    AppSnackBars.success(message: 'Updated successfully');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});
