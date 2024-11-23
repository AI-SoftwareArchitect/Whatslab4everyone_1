
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  late final SharedPreferences _sharedPreferences;

  // Keys
  static const String TOKEN_KEY = 'jwt_token';
  static const String REFRESH_TOKEN_KEY = 'refresh_token';
  static const String TOKEN_EXPIRY_KEY = 'jwt_token_expiry';

  // Private constructor
  SharedPreferenceManager._();

  // Singleton instance
  static final SharedPreferenceManager _instance = SharedPreferenceManager._();

  factory SharedPreferenceManager() => _instance;

  // Initialization method
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Getter for the shared preferences instance
  SharedPreferences get sharedPreferences {
    return _sharedPreferences;
  }

  // JWT Token getter
  String? getJWT_TOKEN() {
    return _sharedPreferences.getString(TOKEN_KEY);
  }

  // JWT Token setter
  Future<bool> setJWT_TOKEN(String newToken) async {
    return await _sharedPreferences.setString(TOKEN_KEY, newToken);
  }

  // Refresh Token getter
  String? getJWT_REFRESH_TOKEN() {
    return _sharedPreferences.getString(REFRESH_TOKEN_KEY);
  }

  // Refresh Token setter
  Future<bool> setJWT_REFRESH_TOKEN(String newRefreshToken) async {
    return await _sharedPreferences.setString(REFRESH_TOKEN_KEY, newRefreshToken);
  }
}