import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Dashboard", style: TextStyle(color: Colors.black)),
        elevation: 0.0,
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.circle), onPressed: () => debugPrint("Tapped"))
        ],
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
                  Icons.library_books,
                  color: Colors.white,
                ),
                title: Text("Stocks")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                title: Text("Fav")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                title: Text("Add")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                title: Text("Menu"))
          ],
          onTap: (int index) => debugPrint("Tapped Item: $index"),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                "Tap Me",
                style: TextStyle(fontSize: 25),
              ),
              onTap: () => debugPrint("tapped..."),
            )
          ],
        ),
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black,
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Text(
//             "Dashboard",
//             textDirection: TextDirection.ltr,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//           ),
//         ),
//       ),
//     );
//   }
// }
