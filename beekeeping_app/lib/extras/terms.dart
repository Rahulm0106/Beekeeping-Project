import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/assets/app_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_trading_advisor/screens/home.dart';

class Terms extends StatefulWidget {
  static const routeName = '/terms';
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  FirebaseUser newUser;
  bool isloggedin = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((newUser) {
      if (newUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      setState(() {
        this.newUser = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  // ignore: must_call_super
  void initState() {
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder("Terms & Conditions"),
      bottomNavigationBar: BottomNav(),
      body: !isloggedin
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: 0.0, right: 20.0, left: 20.0, bottom: 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    head('Term Head'),
                    SizedBox(
                      height: 10.0,
                    ),
                    body(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                    SizedBox(
                      height: 20.0,
                    ),
                    head('Term Head'),
                    SizedBox(
                      height: 10.0,
                    ),
                    body(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                    SizedBox(
                      height: 20.0,
                    ),
                    head('Term Head'),
                    SizedBox(
                      height: 10.0,
                    ),
                    body(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                    SizedBox(
                      height: 20.0,
                    ),
                    head('Term Head'),
                    SizedBox(
                      height: 10.0,
                    ),
                    body(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Container body(String b) {
    return Container(
      child: Text(b,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          )),
    );
  }

  Container head(String h) {
    return Container(
      child: Text(h,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    );
  }
}
