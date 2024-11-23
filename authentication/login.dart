import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LoginManager {
  User user;
  GlobalKey<FormState> key;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  static const String TOKEN_KEY = 'jwt_token';
  static const String REFRESH_TOKEN_KEY = 'refresh_token';
  static const String TOKEN_EXPIRY_KEY = 'jwt_token_expiry';

  LoginManager({
    required this.key,
    required this.user,
    required this.usernameController,
    required this.passwordController,
  });

  void setUser(User user) {
    this.user = user;
  }

  Future<bool> loginAndValidate() async {
    final isValid = _validate();
    if (isValid) {
      return await _login();
    }
    return false;
  }

  bool _validate() {
    return key.currentState?.validate() ?? false;
  }

  Future<bool> _login() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final existingToken = prefs.getString(TOKEN_KEY);

      var headers = <String, String>{
        'Content-Type': 'application/json',
      };

      if (existingToken != null) {
        headers['Authorization'] = 'Bearer $existingToken';
      }

      var url = Uri.http('10.0.2.2:3000', '/login');
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["message"]);
        user.id = data["id"] ?? "no_id";
        user.email = data["email"] ?? "no_mail";
        user.username = usernameController.text;
        user.password = passwordController.text;
        final token = data['token'];
        final refreshToken = data['refreshToken'];
        final expiresIn = data['expiresIn'];

        if (token != null && refreshToken != null) {
          // Token'ı kaydet
          await prefs.setString(TOKEN_KEY, token);

          // Refresh token'ı kaydet
          await prefs.setString(REFRESH_TOKEN_KEY, refreshToken);

          // Süre bilgisini kaydet
          final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
          await prefs.setString(TOKEN_EXPIRY_KEY, expiryTime.toIso8601String());

          return true;
        }
      }

      print('Login failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;

    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(TOKEN_KEY);

      if (token == null) return false;

      final decodedToken = JwtDecoder.decode(token);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);

      if (DateTime.now().isAfter(expiryDate)) {
        // Token'ın süresi doldu, yeni bir token alın
        return await _refreshToken();
      }

      return true;
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString(REFRESH_TOKEN_KEY);

      if (refreshToken == null) return false;

      var url = Uri.http('10.0.2.2:3000', '/refresh-token');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final expiresIn = data['expiresIn'];

        if (token != null) {
          // Token'ı kaydet
          await prefs.setString(TOKEN_KEY, token);

          // Süre bilgisini kaydet
          final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
          await prefs.setString(TOKEN_EXPIRY_KEY, expiryTime.toIso8601String());

          return true;
        }
      }

      print('Refresh token failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;

    } catch (e) {
      print('Refresh token error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(REFRESH_TOKEN_KEY);
    await prefs.remove(TOKEN_EXPIRY_KEY);
  }
}






/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LoginManager {
  User user;
  GlobalKey<FormState> key;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  static const String TOKEN_KEY = 'jwt_token';
  static const String TOKEN_EXPIRY_KEY = 'jwt_token_expiry';

  LoginManager({
    required this.key,
    required this.user,
    required this.usernameController,
    required this.passwordController,
  });

  void setUser(User user) {
    this.user = user;
  }

  Future<bool> loginAndValidate() async {
    final isValid = _validate();
    if (isValid) {
      return await _login();
    }
    return false;
  }

  bool _validate() {
    return key.currentState?.validate() ?? false;
  }

  Future<bool> _login() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final existingToken = prefs.getString(TOKEN_KEY);

      var headers = <String, String>{
        'Content-Type': 'application/json',
      };

      if (existingToken != null) {
        headers['Authorization'] = 'Bearer $existingToken';
      }

      var url = Uri.http('10.0.2.2:3000', '/login');
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["message"]);
        user.id = data["id"] ?? "no_id";
        user.email = data["email"] ?? "no_mail";
        user.username = usernameController.text;
        user.password = passwordController.text;
        final token = data['token'];
        final expiresIn = data['expiresIn'];

        if (token != null) {
          // Token'ı kaydet
          await prefs.setString(TOKEN_KEY, token);

          // Süre bilgisini kaydet
          final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
          await prefs.setString(TOKEN_EXPIRY_KEY, expiryTime.toIso8601String());

          return true;
        }
      }


      print('Login failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;

    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(TOKEN_KEY);

      if (token == null) return false;

      final decodedToken = JwtDecoder.decode(token);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);

      return DateTime.now().isBefore(expiryDate);
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(TOKEN_EXPIRY_KEY);
  }
}
*/
