import 'package:beekeeping_app/Screens/Startpage.dart';
import 'package:flutter/material.dart';
// ignore: duplicate_import
import 'package:beekeeping_app/Screens/Startpage.dart';
import 'Screens/Login.dart';
import 'Screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'beekeeping_app',
      theme: ThemeData(primaryColor: Colors.yellow.shade600),
      home: HomePage(),
      routes: {
        //SignupScreen.routeName: (ctx) => SignupScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        Start.routeName: (ctx) => Start(),
      },
    );
  }
}
