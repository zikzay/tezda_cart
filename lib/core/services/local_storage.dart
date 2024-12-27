import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  /// use this to [saveToken] to local storage
  static Future<void> saveToken(String tokenValue) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("token", tokenValue);
  }

  /// use this to [getToken] from local storage
  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  /// use this to [saveRefreshToken] to local storage
  static Future<void> saveRefreshToken(String refreshTokenValue) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("refreshToken", refreshTokenValue);
  }

  /// use this to [getRefreshToken] from local storage
  static Future<String?> getRefreshToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("refreshToken");
  }

  /// use this to [deleteToken] from local storage
  static Future<void> deleteToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove("token");
  }

  /// use this to [saveUsername] to local storage
  static Future<void> saveUsername(String userName) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('name', userName);
  }

  /// use this to [getUsername] from local storage
  static Future<String?> getUsername() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('name');
  }

  /// use this to [saveUsername] to local storage
  static Future<void> save(String key, value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  /// use this to [getUsername] from local storage
  static Future<String?> get(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  /// use this to [deleteToken] from local storage
  static Future<void> delete(String key) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}
