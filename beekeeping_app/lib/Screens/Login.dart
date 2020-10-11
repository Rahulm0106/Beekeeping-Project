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
        backgroundColor: Colors.grey.shade900,
        body: SingleChildScrollView(
          child: Container(
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
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
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
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow.shade700,
                                      width: 2.0,
                                    ),
                                  ),
                                  labelText: ('Email'),
                                  labelStyle:
                                      TextStyle(color: Colors.yellow.shade700),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.yellow.shade700,
                                  )),
                              onSaved: (value) => _email = value),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              validator: (String value) {
                                if (value.isEmpty || value.length < 8) {
                                  return 'invalid password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow.shade700,
                                      width: 2.0,
                                    ),
                                  ),
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.yellow.shade700),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.yellow.shade700,
                                  )),
                              obscureText: true,
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
                                  style:
                                      TextStyle(color: Colors.yellow.shade700),
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            // width: 50,
                            // alignment: Alignment.center,
                          ),
                          color: Colors.yellow.shade700,
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
                  child: Text(
                    "Don't have an acoount?",
                    style: TextStyle(color: Colors.yellow.shade700),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
