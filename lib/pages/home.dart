import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gestion_notes/controllers/coursController.dart';
import 'package:gestion_notes/controllers/userControllers.dart';
import 'package:gestion_notes/models/user.dart';
import 'package:gestion_notes/pages/coursPage.dart';
import 'package:gestion_notes/pages/login.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:gestion_notes/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   UserController userController = Get.put(UserController());
   CoursController coursController = Get.put(CoursController());

  // User user = null ;
  //
  // String token = "";
  //
  // Future<Null> getToken() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('token');
  // }
  //
  // Future<Null> getUser(String toke) async{
  //   user = await API_Manager().getUser(toke);
  // }
  //


  void initState() {
    // TODO: implement initState
    super.initState();
    userController.connectUser();
    coursController.fetchUserCourses();
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
              child: InkWell(
                onTap: (){
                  coursController.fetchUserCourses();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> CoursPage()));
                },
                child: Column(
                  children: [
                  Image.asset(
                  "assets/images/book.png", height: 123,
                  ),
                  Text("Courses")
                  ],
                ),
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
            // Obx(()=>Text((userController.token==null)?'null':userController.token.value))
          ],
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(()=> UserAccountsDrawerHeader(
              accountName: Text((userController.user.value.nom)),
              accountEmail: Text((userController.user.value.email)),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: (userController.user == null) ? Icon(
                    EvaIcons.personOutline,
                    color: Style.Colors.loginGradientEnd,
                  ):Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage((userController.user.value.avatar==null)?"null":userController.user.value.avatar),
                            fit: BoxFit.fill
                        )
                    ),
                  )
              ),
              decoration: BoxDecoration(color: Style.Colors.mainColor),
            )),
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
              onTap: () async {
                //bool reponse = false;
                bool reponse = await API_Manager().logout(await API_Manager.getToken());
                if (reponse){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deconnexion...'),));

                  Loader.show(context,
                    progressIndicator: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),);

                  Future.delayed(Duration(seconds: 3), () {
                    Loader.hide();
                  });
                  await API_Manager.deleteToken();
                  print(await API_Manager.getToken());
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Login()));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deconnexion failed...'),));

                  Loader.show(context,
                    progressIndicator: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),);

                  Future.delayed(Duration(seconds: 3), () {
                    Loader.hide();
                  });
                }
                print(reponse);
              },
            )
          ],
        ),
      ),
    );
  }
}

