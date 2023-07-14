// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_login_app/screens/signup_screen.dart';
// // import 'bloc/login_bloc/login_bloc.dart';
// // import 'home_screen.dart';
import 'package:flutter_login_app/test/home_page.dart';
import 'package:flutter_login_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/provider/login_data_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginDataProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => const LoginPage(),
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: const LoginPage(),
      routes: routes,
    );
  }
}