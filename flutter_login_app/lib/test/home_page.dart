import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/login_data_provider.dart';



class HomePage extends StatelessWidget {
  static String tag = 'home-page';
  late final email;
  late final password;
  late final country;

  @override
  Widget build(BuildContext context) {
    final loginData = Provider.of<LoginDataProvider>(context);
   email = loginData.email;
    password = loginData.password;
  country = loginData.country;
    const blueColor = Color(0xff4b85ec);

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),

      child: Column(
        children: <Widget>[_logo(), welcomeMessage(), showCredentials()],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: blueColor,
        title: const Text('KistPay'),
      ),
      body: body,
    );
  }
  Widget _logo(){
    return Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/img.png'),
      ),
    );
  }
  Widget welcomeMessage(){
    return  const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome to KistPay',
        style: TextStyle(fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );

  }
  Widget showCredentials(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Your Login Credentials are:\n Email: ${email}\nPassword: ${password}\nCountry: ${country}',
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }
}
