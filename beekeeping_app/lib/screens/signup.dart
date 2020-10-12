import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:beekeeping_app/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beekeeping_app/screens/thankyou.dart';
import 'package:beekeeping_app/Screens/stocklist.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _fname, _lname;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyStocksList()));
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
        backgroundColor: Colors.grey.shade900,
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
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null)
                                  return 'Enter First Name';
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
                                  labelText: ('First Name'),
                                  labelStyle:
                                      TextStyle(color: Colors.yellow.shade700),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.yellow.shade700,
                                  )),
                              onSaved: (value) => _fname = value),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null)
                                  return 'Enter Last Name';
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
                                  labelText: ('Last Name'),
                                  labelStyle:
                                      TextStyle(color: Colors.yellow.shade700),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.yellow.shade700,
                                  )),
                              onSaved: (value) => _lname = value),
                        ),
                        SizedBox(height: 10),
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
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              validator: (String value) {
                                if (value.isEmpty || value.length < 8) {
                                  return 'Invalid Password';
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
                                  labelText: ('Password'),
                                  labelStyle:
                                      TextStyle(color: Colors.yellow.shade700),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.yellow.shade700,
                                  )),
                              obscureText: true,
                              onSaved: (value) => _password = value),
                        ),
                        // Container(
                        //   child: TextFormField(
                        //       validator: (String value) {
                        //         if (_confirm != _password) {
                        //           return 'Type correct password';
                        //         }
                        //         return null;
                        //       },
                        //       decoration: InputDecoration(
                        //         labelText: 'Confirm Password',
                        //         prefixIcon: Icon(Icons.lock),
                        //       ),
                        //       obscureText: true,
                        //       onSaved: (value) => _confirm = value),
                        // ),
                        SizedBox(height: 20),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: _email, password: _password);
                                if (newUser != null) {
                                  var firebaseUser = await _auth.currentUser();
                                  data(firebaseUser);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Thankyou()));
                                }
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Error!!!'),
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
                          child: Container(
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            width: 100,
                            alignment: Alignment.center,
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
                  child: Text('Already have an Account?',
                      style: TextStyle(color: Colors.yellow.shade700)),
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            ),
          ),
        ));
  }

  void data(FirebaseUser firebaseUser) {
    db.collection("user").document(firebaseUser.uid).setData({
      "first-name": _fname,
      "last-name": _lname,
      "email": _email,
    }).then((_) {
      debugPrint("success!");
    });
  }
}
