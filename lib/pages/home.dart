import 'package:flutter/material.dart';
import 'package:gestion_notes/pages/login.dart';
import 'package:gestion_notes/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: Text("Page d'accueil"),
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
