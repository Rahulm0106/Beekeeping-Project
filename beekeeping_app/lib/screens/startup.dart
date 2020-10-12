import 'package:flutter/material.dart';
import 'package:beekeeping_app/screens/login.dart';
import 'package:beekeeping_app/screens/signup.dart';

class Start extends StatefulWidget {
  static const routeName = '/startup';
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 150.0),
            Container(
              height: 200,
              child: Center(
                child: Image(
                  image: AssetImage("images/logo.png"),
                  //height: 150,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            RichText(
                text: TextSpan(
              text: 'Beekeeping',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow.shade700),
            )),
            SizedBox(height: 10.0),
            Text(
              'Make Smart Decision',
              style: TextStyle(color: Colors.yellow.shade700),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.yellow.shade700),
                SizedBox(width: 20.0),
                RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.yellow.shade700),
              ],
            ),
            SizedBox(height: 125.0),
            Column(children: <Widget>[
              Container(
                child: Text('DISCLAIMER:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade700,
                    )),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Text(
                    'Inacurracies may arrive in data due to unforseen circumstances',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.yellow.shade700,
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
