import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Trading Advisor',
      theme: ThemeData(primaryColor: Colors.black),
      home: HomePage(),
    );
  }
}
