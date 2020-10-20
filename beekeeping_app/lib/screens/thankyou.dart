import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beekeeping_app/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Thankyou extends StatefulWidget {
  static const routeName = '/thankyou';
  @override
  _ThankyouState createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  FirebaseUser newUser;
  bool isloggedin = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((newUser) {
      if (newUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      backgroundColor: Colors.grey.shade900,
      body: Container(
        child: !isloggedin
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Container(
                    height: 200,
                    child: Image(
                      image: AssetImage("images/logo.png"),
                      height: 210,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: data(),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                    onPressed: () async {
                      _auth.signOut();
                    },
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    color: Colors.yellow.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
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
          return Column(children: <Widget>[
            Container(
              child: Text('Hello',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height : 10,
            ),
            Container(
              child: Text(
                '${documentFields["first-name"]} ${documentFields["last-name"]}',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade700),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(
                  'Welcome to Beehive Monitoring App, Thank You for signing up!!!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),textAlign: TextAlign.center,),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text('Login again to make smarter decision...',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),textAlign: TextAlign.center,),
            ),
          ]);
        } else {
          return Text('Some Error');
        }
      },
    );
  }
}
