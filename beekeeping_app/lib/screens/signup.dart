import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_trading_advisor/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_trading_advisor/screens/thankyou.dart';

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
                            if (value == null)
                              return 'Enter First Name';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              prefixIcon: Icon(Icons.person)),
                          onSaved: (value) => _fname = value),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (value) {
                            if (value == null)
                              return 'Enter Last Name';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Last Name',
                              prefixIcon: Icon(Icons.person)),
                          onSaved: (value) => _lname = value),
                    ),
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
                    Container(
                      child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty || value.length < 8) {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
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
              child: Text('Already have an Account?'),
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
