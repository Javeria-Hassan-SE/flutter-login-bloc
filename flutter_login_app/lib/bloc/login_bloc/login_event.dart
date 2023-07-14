

import 'package:flutter/material.dart';

abstract class LoginEvent {}
//event for GetUserLogin
class GetLogin extends LoginEvent {
  String? email;
  String? password;
  String? country;
  BuildContext context;

  GetLogin({this.email, this.password,this.country , required this.context});
}