import 'dart:convert';

import 'package:tezda_cart/core/models/user.dart';
import 'package:tezda_cart/core/services/local_storage.dart';
import 'package:tezda_cart/core/widgets/snack_bar.dart';

import 'app_service.dart';

class AuthService {
  BaseService service = BaseService();

  Future<User?> register(String email, String password) async {
    var user = User(email: email, password: password);
    try {
      final List<dynamic> jsonData = jsonDecode((await LocalStorage.get('users')) ?? '[]');

      List<User> users = jsonData.map((item) => User.fromJson(item)).toList();

      if (users.any((u) => u.email == user.email)) {
        AppSnackBars.error(message: 'User with email exist');
        return null;
      }

      final currentUser = jsonEncode(user.toJson());
      LocalStorage.save('currentUser', currentUser);
      LocalStorage.save('users', jsonEncode([...users, user]));

      AppSnackBars.success(message: 'Registration successful');

      return user;
    } catch (err) {
      AppSnackBars.error(message: 'Something went wrong!');
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    var user = User(email: email, password: password);
    try {
      final List<dynamic> jsonData = jsonDecode((await LocalStorage.get('users')) ?? '[]');

      List<User> users = jsonData.map((item) => User.fromJson(item)).toList();
      final foundUser = users.firstWhere((u) => u.email == user.email);

      if (foundUser.password != password) {
        AppSnackBars.error(message: 'Incorrect login credential');
        return null;
      }

      final currentUser = jsonEncode(foundUser.toJson());
      LocalStorage.save('currentUser', currentUser);

      AppSnackBars.success(message: 'Login successful');

      return user;
    } catch (err) {
      AppSnackBars.error(message: 'Incorrect login credential');
      return null;
    }
  }

  Future<bool?> logout() async {
    try {
      await LocalStorage.delete('currentUser');
      return true;
    } catch (err) {
      AppSnackBars.error(message: 'Incorrect login credential');
      return false;
    }
  }

  Future<void> updateUserInfo({
    required String firstName,
    required String lastName,
    String? image,
  }) async {
    try {
      final String? currentUserData = await LocalStorage.get('currentUser');
      if (currentUserData != null) {
        User savedUser = User.fromJson(jsonDecode(currentUserData));

        User currentUser = User(
          email: savedUser.email,
          password: savedUser.password,
          firstName: firstName,
          lastName: lastName,
          image: image,
        );

        final List<dynamic> jsonData = jsonDecode((await LocalStorage.get('users')) ?? '[]');
        List<User> users = jsonData.map((item) => User.fromJson(item)).toList();

        final userIndex = users.indexWhere((u) => u.email == currentUser.email);
        if (userIndex != -1) {
          users[userIndex] = currentUser;
        }
        LocalStorage.save('currentUser', jsonEncode(currentUser.toJson()));
        LocalStorage.save('users', jsonEncode(users));
      }
    } catch (err) {
      AppSnackBars.error(message: 'Something went wrong!');
    }
  }

  Future<User?> getUserInfo() async {
    final String? currentUserData = await LocalStorage.get('currentUser');
    if (currentUserData != null) {
      User currentUser = User.fromJson(jsonDecode(currentUserData));
      return currentUser;
    }
    return null;
  }
}
