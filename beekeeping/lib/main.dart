import 'package:flutter/material.dart';
import 'package:try_flutter/screens/home.dart';
import 'package:try_flutter/screens/login.dart';
import 'package:try_flutter/screens/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'trial app',
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginScreen(),
      routes: {
        SignupScreen.routeName: (ctx) => SignupScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        Dashboard.routeName: (ctx) => Dashboard(),
      },
    );
  }
}
