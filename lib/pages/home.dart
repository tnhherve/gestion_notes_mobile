import 'package:flutter/material.dart';
import 'package:gestion_notes/pages/login.dart';
import 'package:gestion_notes/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String token = "";
  Future<Null> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  @override
  initState() {
    super.initState();
    token = "";
    getToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Style.Colors.mainColor,
        title: Center(child: Text("GND")),
        actions: [
          IconButton(
              icon: Icon(
                EvaIcons.search,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5.0,20,5,5),
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          primary: false,
          children: [

            Card(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/book.png", height: 123,
                  ),
                  Text("Courses")
                ],
              ),
            ),

            Card(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/board.png", height: 123,
                  ),
                  Text("Planning")
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/programming.png", height: 123,
                  ),
                  Text("Code")
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/board.png", height: 123,
                  ),
                  Text("Autres")
                ],
              ),
            ),
            Text(token)
          ],
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("herve"),
              accountEmail: Text("tnhherve@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  EvaIcons.personOutline,
                  color: Style.Colors.loginGradientEnd,
                ),
              ),
              decoration: BoxDecoration(color: Style.Colors.mainColor),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.home,
                color: Style.Colors.orange,
              ),
              title: Text("Accueil"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                EvaIcons.person,
                color: Style.Colors.orange,
              ),
              title: Text("Mon compte"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                EvaIcons.calendar,
                color: Style.Colors.orange,
              ),
              title: Text("Evenements"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                EvaIcons.settings,
                color: Style.Colors.orange,
              ),
              title: Text("A propos"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                EvaIcons.logOut,
                color: Style.Colors.orange,
              ),
              title: Text("Deconnexion"),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            )
          ],
        ),
      ),
    );
  }
}

// Future<List<User>>getUser(){
//   final Uri baseUrl =
//   Uri.parse("https://api-ccnb-gestion-notes.herokuapp.com/api/user/profile");
//   var response = await http.get(baseUrl);
//   print(response.statusCode);
//
// }