import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beekeeping_app/screens/home.dart';

class MyLocationsList extends StatefulWidget {
  static const routeName = '/locations';
  @override
  _MyLocationsListState createState() => _MyLocationsListState();
}

class _MyLocationsListState extends State<MyLocationsList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore db = Firestore.instance;
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
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  Widget _locationList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: IconButton(
          icon: Icon(Icons.analytics_outlined),
          onPressed: () async {
            try {
              if (newUser != null) {
                // var firebaseUser = await _auth.currentUser();
                // data(firebaseUser, document['beehive-no'],
                //     document['location-name']);
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
          }),
      title: Text(document['location-name']),
      subtitle: Text(document['beehive-no']),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          try {
            if (newUser != null) {
              var firebaseUser = await _auth.currentUser();
              delete(firebaseUser, document['beehive-no']);
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
        },
      ),
      onTap: () async {
        try {
          if (newUser != null) {
            var firebaseUser = await _auth.currentUser();
            analysis(firebaseUser, document['beehive-no']);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Analysis()));
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isloggedin
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            // appBar: appBarBuilder("My Stocks List"),
            // bottomNavigationBar: BottomNav(),
            body: StreamBuilder(
                stream: db
                    .collection('user')
                    .document(newUser.uid)
                    .collection('locations')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No Locations");
                  }
                  return ListView.builder(
                    // itemExtent: 50.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return _locationList(
                          context, snapshot.data.documents[index]);
                    },
                  );
                }));
  }

  void delete(FirebaseUser firebaseUser, String _symbol) {
    db
        .collection("user")
        .document(firebaseUser.uid)
        .collection("locations")
        .document(_symbol)
        .delete();
    // db
        // .collection("user")
        // .document(firebaseUser.uid)
        // .collection("dashboard")
        // .document(_symbol)
        // .delete();
  }

  void analysis(FirebaseUser firebaseUser, String _symbol) {
    db.collection("user").document(firebaseUser.uid).updateData({
      "analysis-location": _symbol,
    }).then((_) {
      debugPrint("success!");
    });
  }

  // void data(FirebaseUser firebaseUser, String _symbol, String _stockname) {
  //   db
  //       .collection("user")
  //       .document(firebaseUser.uid)
  //       .collection("dashboard")
  //       .document(_symbol)
  //       .setData({
  //     "location-name": _stockname,
  //     "beehive-no": _symbol,
  //   }).then((_) {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Success!!!'),
  //             content: Text('Successfully added stock to dashboard'),
  //             actions: <Widget>[
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('OK'))
  //             ],
  //           );
  //         });
  //   });
  // }
}
