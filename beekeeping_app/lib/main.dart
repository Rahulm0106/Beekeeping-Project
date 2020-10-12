import 'package:beekeeping_app/Screens/stocklist.dart';
import 'package:flutter/material.dart';

import 'package:beekeeping_app/Screens/thankyou.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Trading Advisor',
      theme: ThemeData(primaryColor: Colors.black),
      home: MyStocksList(),
    );
  }
}
