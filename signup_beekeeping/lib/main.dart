import 'package:flutter/material.dart';
import 'package:signup_beekeeping/screens/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Trading Advisor',
      theme: ThemeData(primaryColor: Colors.black),
      home: SignupScreen(),
    );
  }
}
