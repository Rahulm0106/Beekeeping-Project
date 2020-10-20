import 'package:beekeeping_app/Screens/addlocation.dart';
import 'package:beekeeping_app/Screens/locationlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beekeeping_app/extras/faqs.dart';
import 'package:beekeeping_app/extras/profile.dart';
import 'package:beekeeping_app/extras/terms.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

Widget appBarBuilder(String text) {
  return AppBar(
    leading: BackButton(color: Colors.black),
    backgroundColor: Colors.yellow.shade700,
    title: Text(text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),

    // iconTheme: IconThemeData(color: Colors.black),
    // title: Text(text, style: TextStyle(color: Colors.black)),
    // elevation: 0.0,
    // centerTitle: false,
    // backgroundColor: Colors.white,
    // actions: <Widget>[
    //   IconButton(
    //       icon: Icon(MyFlutterApp.image2vector),
    //       onPressed: () => debugPrint("Tapped"))
    // ],
  );
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        backgroundColor: Colors.yellow.shade700,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: "Locations"),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.star,
          //       color: Colors.white,
          //     ),
          //     label: "Fav"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: "Home"),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //     ),
          //     label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              label: "Menu")
        ],
        onTap: (int index) {
          if (index == 2) {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.black,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                            height: (56 * 4).toDouble(),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                    color: Colors.black38,
                                    border: Border.all(
                                      color: Colors.grey.shade900,
                                      width: 4,
                                    )),
                                child: Stack(
                                  alignment: Alignment(0, 0),
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    Positioned(
                                      child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                              "Profile",
                                              style: TextStyle(
                                                  color: Colors.yellow.shade700),
                                            ),
                                            leading: Icon(
                                              Icons.person,
                                              color: Colors.yellow.shade700,
                                            ),
                                            onTap: () {
                                              debugPrint("Profile");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profile()));
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "FAQs",
                                              style: TextStyle(
                                                  color: Colors.yellow.shade700),
                                            ),
                                            leading: Icon(
                                              Icons.question_answer,
                                              color: Colors.yellow.shade700,
                                            ),
                                            onTap: () {
                                              debugPrint("FAQ");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FAQs()));
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Terms & Conditions",
                                              style: TextStyle(
                                                  color: Colors.yellow.shade700),
                                            ),
                                            leading: Icon(
                                              Icons.list,
                                              color: Colors.yellow.shade700,
                                            ),
                                            onTap: () {
                                              debugPrint("T&C");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Terms()));
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Logout",
                                              style: TextStyle(
                                                  color: Colors.yellow.shade700),
                                            ),
                                            leading: Icon(
                                              Icons.logout,
                                              color: Colors.yellow.shade700,
                                            ),
                                            onTap: () async {
                                              debugPrint("Logout");
                                              _auth.signOut();
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))),
                        Container(
                          height: 56,
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  );
                });
          } else if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addlocation()));
            // } else if (index == 1) {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => HomePage()));
            //} else if (index == 1) {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Favorites()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyLocationslist()));
          } else {
            debugPrint("Tapped Item: $index");
          }
        },
      ),
    );
  }
}
