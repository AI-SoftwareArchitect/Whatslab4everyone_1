import 'package:flutter/material.dart';

Map<String,String> errorTypes = {
  'empty':'Input field must not be empty!',
  'not_strong':'Password must be stronger. Password must include has one uppercase character',
  'passwordRepeat': 'Password and password repeat must be same.',
  'email': 'Emails must be like email@mail.com',
};

RegExp _regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\.!@#\$&*~]).{8,}$');
RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

String _passwordCheck = "";

FormFieldValidator<String> usernameValidator = (value) {
    if (value!.isEmpty) {
      return errorTypes['empty'];
    }
    return null;
};

FormFieldValidator<String> passwordValidator = (value) {
    _passwordCheck = value.toString();
    if (value!.isEmpty) {
      return errorTypes['empty'];
    }
    else if (!_regex.hasMatch(value)) {
      return errorTypes['not_strong'];
    }
    else {
      return null;
    }
};

FormFieldValidator<String> signupValidator = (value) {
  print("---------------------");
  print(value);
  print(_passwordCheck);
  if (_passwordCheck.compareTo(value.toString()) != 0) {
    return errorTypes['passwordRepeat'];
  }
  return null;
};

FormFieldValidator<String> emailValidator = (value) {
  if (!_emailRegex.hasMatch(value.toString())) return errorTypes['email'];
  return null;
};
