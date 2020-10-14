import 'package:beekeeping_app/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:beekeeping_app/assets/app_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beekeeping_app/assets/beeicon_icons.dart';

class MyLocationslist extends StatefulWidget {
  static const routeName = '/locationlist';
  @override
  _MyLocationslistState createState() => _MyLocationslistState();
}

class _MyLocationslistState extends State<MyLocationslist> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore db = Firestore.instance;
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
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  Widget _locationList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Beeicon.beeicon, color: Colors.yellow.shade700,),
        onPressed: () {},
      ),
      title: Text(document['location-name'],style: TextStyle(color: Colors.yellow.shade700, fontWeight: FontWeight.bold),),
      subtitle: Text(document['location-symbol'], style : TextStyle(color : Colors.yellow.shade700, fontWeight: FontWeight.bold)),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.yellow.shade700,),
        onPressed: () async {
          try {
            if (newUser != null) {
              var firebaseUser = await _auth.currentUser();
              delete(firebaseUser, document['location-id']);
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
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isloggedin
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.grey.shade900,
            appBar: appBarBuilder("My Locations"),
            bottomNavigationBar: BottomNav(),
            body: StreamBuilder(
                stream: db
                    .collection('user')
                    .document(newUser.uid)
                    .collection('locationlist')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No Locations available");
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

  void delete(FirebaseUser firebaseUser, String _locationid) {
    db
        .collection("user")
        .document(firebaseUser.uid)
        .collection("locationlist")
        .document(_locationid)
        .delete();
  }

  // void analysis(FirebaseUser firebaseUser, String _locationid) {
  //   db.collection("user").document(firebaseUser.uid).updateData({
  //     "analysis-location": _locationid,
  //   }).then((_) {
  //     debugPrint("success!");
  //   });
  // }

  // void data(FirebaseUser firebaseUser, String _locationid, String _locationname) {
  //   db
  //       .collection("user")
  //       .document(firebaseUser.uid)
  //       .collection("dashboard")
  //       .document(_locationid)
  //       .setData({
  //     "location-name": _locationname,
  //     "beehiveno": _locationid,
  //   }).then((_) {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Success!!!'),
  //             content: Text('Successfully added location to dashboard'),
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
