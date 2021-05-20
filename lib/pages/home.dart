import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gestion_notes/controllers/coursController.dart';
import 'package:gestion_notes/controllers/evaluationController.dart';
import 'package:gestion_notes/controllers/userControllers.dart';
import 'package:gestion_notes/models/user.dart';
import 'package:gestion_notes/pages/coursPage.dart';
import 'package:gestion_notes/pages/evenementPage.dart';
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

   UserController _userController = Get.put(UserController());
   CoursController _coursController = Get.put(CoursController());
   EvaluationController _evaluationController = Get.put(EvaluationController());

  void initState() {
    // TODO: implement initState
    super.initState();
    _userController.connectUser();
    _coursController.fetchUserCourses();
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
                  _coursController.fetchUserCourses();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> CoursPage()));
                },
                child: Column(
                  children: [
                  Image.asset(
                  "assets/images/cours.png", height: 123,
                  ),
                  Text("Courses")
                  ],
                ),
              ),
            ),

            Card(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> EvenementPage()));
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/event.png", height: 123,
                    ),
                    Text("Evenements")
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/stat.png", height: 123,
                  ),
                  Text("Statistiques")
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/test.png", height: 123,
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
              accountName: Text((_userController.user.value.nom)),
              accountEmail: Text((_userController.user.value.email)),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: (_userController.user == null) ? Icon(
                    EvaIcons.personOutline,
                    color: Style.Colors.loginGradientEnd,
                  ):Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage((_userController.user.value.avatar==null)?"null":_userController.user.value.avatar),
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
                  _coursController.coursList.value.data = [];
                  _evaluationController.evaluations.value.data = [];
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

