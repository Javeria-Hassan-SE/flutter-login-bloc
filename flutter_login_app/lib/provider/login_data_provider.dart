import 'package:flutter/material.dart';

class LoginDataProvider extends ChangeNotifier {
  String? email;
  String? password;
  String? country;

  void updateLoginData(String? email, String? password, String? country) {
    this.email = email;
    this.password = password;
    this.country = country;
    notifyListeners();
  }
}