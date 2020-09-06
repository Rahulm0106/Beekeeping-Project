import 'package:flutter/material.dart';
import 'package:beekeeping_project/screens/startup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'beekeeping_project',
      theme: ThemeData(primaryColor: Colors.yellow.shade600),
      home: Start(),
      //routes: {
      //SignupScreen.routeName: (ctx) => SignupScreen(),
      //LoginScreen.routeName: (ctx) => LoginScreen(),
      //HomePage.routeName: (ctx) => HomePage(),
      //Start.routeName: (ctx) => Start(),
      //},
    );
  }
}
