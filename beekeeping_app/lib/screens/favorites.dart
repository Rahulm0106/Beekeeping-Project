import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/assets/app_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_trading_advisor/screens/home.dart';

class Favorites extends StatefulWidget {
  static const routeName = '/favorites';
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
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
      appBar: appBarBuilder("Favorites"),
      bottomNavigationBar: BottomNav(),
      body: Container(
        child: !isloggedin
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Container(
                    height: 300,
                    child: Image(
                      image: AssetImage("images/logo.png"),
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: data(),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> data() {
    return StreamBuilder(
      stream: db.collection('user').document(newUser.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> documentFields = snapshot.data.data;
          return RichText(
              text: TextSpan(
                  text: '${documentFields['first-name']}',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                TextSpan(
                    text: '${documentFields['last-name']}',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(62, 72, 184, 1.0)))
              ]));
        } else {
          return Text('Some Error');
        }
      },
    );
  }
}
