import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_trading_advisor/extras/faqs.dart';
import 'package:smart_trading_advisor/extras/profile.dart';
import 'package:smart_trading_advisor/extras/terms.dart';
import 'package:smart_trading_advisor/screens/addstocks.dart';
import 'package:smart_trading_advisor/screens/favorites.dart';
import 'package:smart_trading_advisor/screens/home.dart';
import 'package:smart_trading_advisor/screens/stocklist.dart';
import 'my_flutter_app_icons.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Widget appBarBuilder(String text) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(text, style: TextStyle(color: Colors.black)),
    elevation: 0.0,
    centerTitle: false,
    backgroundColor: Colors.white,
    actions: <Widget>[
      IconButton(
          icon: Icon(MyFlutterApp.image2vector),
          onPressed: () => debugPrint("Tapped"))
    ],
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
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                color: Colors.white,
              ),
              label: "Stocks"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              label: "Fav"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              label: "Menu")
        ],
        onTap: (int index) {
          if (index == 4) {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
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
                                    color: Colors.grey,
                                    border: Border.all(
                                      color: Colors.black,
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
                                                  color: Colors.black),
                                            ),
                                            leading: Icon(
                                              Icons.person,
                                              color: Colors.black,
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
                                                  color: Colors.black),
                                            ),
                                            leading: Icon(
                                              Icons.question_answer,
                                              color: Colors.black,
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
                                                  color: Colors.black),
                                            ),
                                            leading: Icon(
                                              Icons.list,
                                              color: Colors.black,
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
                                                  color: Colors.black),
                                            ),
                                            leading: Icon(
                                              Icons.logout,
                                              color: Colors.black,
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
          } else if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddStocks()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Favorites()));
          } else if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyStocksList()));
          } else {
            debugPrint("Tapped Item: $index");
          }
        },
      ),
    );
  }
}
