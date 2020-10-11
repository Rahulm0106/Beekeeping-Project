import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/screens/home.dart';
import 'package:smart_trading_advisor/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _email, _password;

  bool _isHidden = true;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0, bottom: 0.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Image(
                image: AssetImage("images/logo.png"),
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (value.isEmpty || !regex.hasMatch(value))
                              return 'Enter Valid Email Id!!!';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Email', prefixIcon: Icon(Icons.email)),
                          onSaved: (value) => _email = value),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty || value.length < 8) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                                icon: _isHidden
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              )),
                          obscureText: _isHidden,
                          onSaved: (value) => _password = value),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                try {
                                  await _auth.sendPasswordResetEmail(
                                      email: _email);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Forgot Password'),
                                          content: Text(
                                              'An email with your password verification link has been successfully sent to you registered email ID, please click on the link to generate a new password...'),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'))
                                          ],
                                        );
                                      });
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('ERROR'),
                                          content: Text('$e'),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'))
                                          ],
                                        );
                                      });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: _email, password: _password);
                            if (newUser != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Wrong Email or Password'),
                                    content: Text(
                                        '$e\n\nPlease recheck your Email ID and Password'),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Container(
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        width: 100,
                        alignment: Alignment.center,
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              child: Text("Don't have an acoount?"),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            )
          ],
        ),
      ),
    ));
  }
}
