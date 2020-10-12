import 'package:flutter/material.dart';
import 'package:beekeeping_app/assets/app_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beekeeping_app/screens/home.dart';

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

  String _locationname, _beehiveno,_locationid;

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
      backgroundColor: Colors.grey.shade900,
      resizeToAvoidBottomPadding: true,
      appBar : appBarBuilder('Add Locations'),


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
                        image: AssetImage("images/logo.png"),
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
                                    enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow.shade700,
                                      width: 2.0,
                                    ),
                                  ),
                                      labelText: 'Location Id',
                                      labelStyle: TextStyle(color: Colors.yellow.shade700) ,
                                      prefixIcon: Icon(Icons.location_city, color: Colors.yellow.shade700,)),
                                  onSaved: (value) => _locationid = value),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: TextFormField(
                                  //validator: (){},
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow.shade700,
                                      width: 2.0,
                                    ),
                                  ),
                                      labelText: 'Location Name',
                                      labelStyle: TextStyle(color: Colors.yellow.shade700) ,
                                      prefixIcon: Icon(Icons.location_city, color: Colors.yellow.shade700,)),
                                  onSaved: (value) => _locationname = value),
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
                                    enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow.shade700,
                                      width: 2.0,
                                    ),
                                  ),
                                    labelText: 'Number of beehives', labelStyle: TextStyle(color: Colors.yellow.shade700),
                                    prefixIcon: Icon(Icons.confirmation_number, color: Colors.yellow.shade700),
                                  ),
                                  onSaved: (value) => _beehiveno = value),
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
                                child: Text('Add Location',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                width: 120,
                                alignment: Alignment.center,
                              ),
                              color: Colors.yellow.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text('Things to keep in mind...',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow.shade700,
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text('Search the locations online',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.yellow.shade700,
                          )),
                    ),
                    Container(
                      child: Text('Ensure the legal farms',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.yellow.shade700,
                          )),
                    ),
                    Container(
                      child: Text('Recheck to make sure there are no mistakes',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.yellow.shade700,
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
        .collection("locationlist")
        .document(_locationid)
        .setData({
          "location-id": _locationid,
      "location-name": _locationname,
      "location-symbol": _beehiveno,
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
