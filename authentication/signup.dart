import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class SignupManager {

  User user;
  GlobalKey<FormState> key;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;

  SignupManager({required this.key, required this.user,
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
  });

  void setUser(User user) {
    this.user = user;
  }

  Future<bool> validateAndSignup() async {
    user.username = usernameController.text;
    user.password = passwordController.text;
    user.email = emailController.text;
    print(user.toString());
    if (_validate()) {

        var url = Uri.http('10.0.2.2:3000', 'signup');
        var response = await http.post(url,body: user.toJson());
        if (response.statusCode == 200) {
          print('signup successfull!');
            return true;
        }
    }
    return false;
  }

  bool _validate() {
    if (key.currentState!.validate()) return true;
    return false;
  }


}