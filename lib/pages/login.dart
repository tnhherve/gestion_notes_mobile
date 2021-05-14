import 'package:flutter/material.dart';
import 'package:gestion_notes/pages/home.dart';
import 'package:gestion_notes/pages/register.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:gestion_notes/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  // pour sauvegarder les donnees sur le disque
  //final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 250,
            child: Image.asset(
              "assets/images/logoFinal.png",
              fit: BoxFit.fill,
              height: 300,
              width: 400,
              alignment: Alignment.center ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 150.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                      height: 100.0,
                      padding: EdgeInsets.only(bottom: 10.0, top: 50.0),
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Quick note",
                              style: TextStyle(
                                  color: Style.Colors.mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0),
                            ),
                          ),

                        ],
                      )),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(EvaIcons.emailOutline, color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Style.Colors.mainColor),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "E-Mail",
                      hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Style.Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value.isEmpty || value==null) {
                        return "Email est obligatoire";
                      }
                      return null;
                    },
                    autocorrect: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        EvaIcons.lockOutline,
                        color: Colors.black26,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Style.Colors.mainColor),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "Mot de passe",
                      hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Style.Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    autocorrect: false,
                    obscureText: true,
                    validator: (value) {
                      if (value == null && value.isEmpty){
                        return "mot de passe obligatoire";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: new InkWell(
                  //       child: new Text(
                  //         "mot de pass oublié?",
                  //         style:
                  //             TextStyle(color: Colors.black45, fontSize: 12.0),
                  //       ),
                  //       onTap: () {}),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                            height: 45,
                            child: RaisedButton(
                                color: Style.Colors.mainColor,
                                disabledColor: Style.Colors.mainColor,
                                disabledTextColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connexion'),));
                                    Loader.show(context,
                                      progressIndicator: CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                      ),);

                                    Future.delayed(Duration(seconds: 5), () {
                                      Loader.hide();
                                    });
                                    String message = null;
                                    message = await API_Manager().login(_emailController.text,
                                        _passwordController.text);

                                    //print(message);
                                    if (message != 'unauthorized'){

                                      await API_Manager.deleteToken();

                                      await API_Manager.writeToken(message);
                                      Navigator.pushReplacement(context,
                                       new MaterialPageRoute(builder: (context)=> new HomePage()));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email ou mot de passe incorrect'),));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email et mot de passe obligatoire'),));
                                  }

                                },
                                child: Text("CONNEXION",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)))),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Se connectez avec",
                        style: TextStyle(color: Colors.black26, fontSize: 12.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.0,
                        width: 150.0,
                        child: RaisedButton(
                            color: Color(0xFF385c8e),
                            disabledColor: Style.Colors.mainColor,
                            disabledTextColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  EvaIcons.facebook,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("Facebook",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            )),
                      ),
                      Container(
                        width: 150.0,
                        height: 40.0,
                        child: RaisedButton(
                            color: Color(0xFFf14436),
                            disabledColor: Style.Colors.mainColor,
                            disabledTextColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  EvaIcons.google,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("Google",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Tu n'as pas de compte?",
                                style: TextStyle(color: Style.Colors.grey),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new Register()));
                                  },
                                  child: Text(
                                    "Créer un",
                                    style: TextStyle(
                                        color: Style.Colors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


