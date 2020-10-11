import 'package:beekeeping_app/Screens/newuser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beekeeping_app/screens/startpage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser newUser;
  bool isloggedin = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Dashboard", style: TextStyle(color: Colors.black)),
        elevation: 0.0,
        centerTitle: false,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.circle), onPressed: () => debugPrint("Tapped"))
        ],
      ),
      body: Container(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Container(
                    height: 300,
                    child: Image(
                      alignment: Alignment.topRight,
                      image: AssetImage("images/logo.png"),
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.topCenter,
                  //   child: Text(
                  //     "Hello!!! you are Logged in as ${newUser.email}",
                  //     // style: TextStyle(
                  //     //     fontSize: 20.0, fontWeight: FontWeight.bold),
                  //   ),
                  //   padding: EdgeInsets.all(10),
                  // ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image(
                      image: AssetImage("images/1.jpg"),
                      height : 100,
                      width : 100,
                      fit : BoxFit.contain,

                    ),
                  ),
                  // RaisedButton(
                  //   padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  //   onPressed: signOut,
                  //   child: Text('Signout',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold)),
                  //   color: Colors.orange,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20.0),
                  //   ),
                  // )
                ],
              ),
      ),
      
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_phone,
                  color: Colors.white,
                ),
                // ignore: deprecated_member_use
                title : Text("Contact Us")),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.star,
            //       color: Colors.white,
            //     ),
            //     title: Text("Fav")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                // ignore: deprecated_member_use
                title: Text("Home")),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.add,
            //       color: Colors.white,
            //     ),
            //     // ignore: deprecated_member_use
            //     title: Text("Add")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                // ignore: deprecated_member_use
                title: Text("Log Out"))
          ],
          onTap: (int index) {
            if (index == 2) {
              signOut();
            } else {
              debugPrint("Tapped Item: $index");
            }
          
          
            if (index == 0) {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewUser()));
              // routes: {
                
              // },

            }

           },
        ),
      ),
    );
  }
}

// class Dashboard extends StatelessWidget {
//   static const routeName = '/home';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text("Dashboard", style: TextStyle(color: Colors.black)),
//         elevation: 0.0,
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.circle), onPressed: () => debugPrint("Tapped"))
//         ],
//       ),
//
//       backgroundColor: Colors.white,
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             InkWell(
//               child: Text(
//                 "Tap Me",
//                 style: TextStyle(fontSize: 25),
//               ),
//               onTap: () => debugPrint("tapped..."),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
