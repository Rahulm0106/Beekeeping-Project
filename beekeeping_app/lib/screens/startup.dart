import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/screens/login.dart';
import 'package:smart_trading_advisor/screens/signup.dart';

class Start extends StatefulWidget {
  static const routeName = '/startup';
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 300,
              child: Image(
                image: AssetImage("images/logo.png"),
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            RichText(
                text: TextSpan(
                    text: 'Smart Trading ',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'App',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(62, 72, 184, 1.0)))
                ])),
            SizedBox(height: 10.0),
            Text(
              'Predict the future',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 75.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.only(left: 45, right: 45),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.black),
                SizedBox(width: 10.0),
                RaisedButton(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.black),
              ],
            ),
            SizedBox(height: 125.0),
            Column(children: <Widget>[
              Container(
                child: Text('DISCLAIMER:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text(
                    'Stock market investments are subject to market risks. Read all Terms and Conditions carefully!',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    )),
              ),
            ])
            // SignInButton(
            //   Buttons.Google,
            //   text: "Sign up with Google",
            //   onPressed: () {},
            // )
          ],
        ),
      ),
    );
  }
}
