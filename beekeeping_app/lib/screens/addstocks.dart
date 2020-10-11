import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/assets/app_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_trading_advisor/screens/home.dart';

class AddStocks extends StatefulWidget {
  static const routeName = '/addstocks';
  @override
  _AddStocksState createState() => _AddStocksState();
}

class _AddStocksState extends State<AddStocks> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  FirebaseUser newUser;
  bool isloggedin = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  String _stockname, _symbol;

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
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBarBuilder("Add Stocks"),
      bottomNavigationBar: BottomNav(),
      body: !isloggedin
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: 0.0, right: 20.0, left: 20.0, bottom: 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 180,
                      child: Image(
                        image: AssetImage("images/addstock.png"),
                        //height: 130,
                        // width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  //validator: (){},
                                  decoration: InputDecoration(
                                      hintText: 'Stock Name',
                                      prefixIcon: Icon(Icons.money)),
                                  onSaved: (value) => _stockname = value),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: TextFormField(
                                  // validator: (String value) {
                                  //   if (value.isEmpty || value.length < 8) {
                                  //     return 'invalid password';
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    hintText: 'Stock Symbol',
                                    prefixIcon: Icon(Icons.monetization_on),
                                  ),
                                  onSaved: (value) => _symbol = value),
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  try {
                                    if (newUser != null) {
                                      var firebaseUser =
                                          await _auth.currentUser();
                                      data(firebaseUser);
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
                                child: Text('Add Stock',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Text('Things to keep in mind...',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Text('Search Google to get stock name and symbol',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          )),
                    ),
                    Container(
                      child: Text('Make sure the symbol is in allcaps',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          )),
                    ),
                    Container(
                      child: Text('Recheck to amke sure there are no mistakes',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void data(FirebaseUser firebaseUser) {
    db
        .collection("user")
        .document(firebaseUser.uid)
        .collection("stocklist")
        .document(_symbol)
        .setData({
      "stock-name": _stockname,
      "stock-symbol": _symbol,
    }).then((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success!!!'),
              content: Text('Successfully added stock to stock list.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    });
  }
}
