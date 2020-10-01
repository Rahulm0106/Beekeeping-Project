import 'package:beekeeping_app/Screens/Login.dart';
import 'package:beekeeping_app/Screens/Startpage.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  static const routeName = '/NewUser';
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New User',
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
            title: const Text(
              'New User',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.yellow.shade700),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
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
            icon: Icon(Icons.contact_phone),
            title: Text(
              "Contact Us",
              textDirection: TextDirection.ltr,
            ),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.close), title: Text("Exit"))
        ],
        onTap: (int index) {
          if (index == 0) {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: (56 * 2).toDouble(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                color: Colors.grey.shade800,
                                border: Border.all(
                                  color: Colors.yellow.shade800,
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
                                        "123567890",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      leading: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "abc@xyz.com",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      leading: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Start()));
          }
        },
      ),
    );
  }
}
