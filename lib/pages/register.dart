import 'package:flutter/material.dart';
import 'package:gestion_notes/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController =
      new TextEditingController();
  final TextEditingController _nomTextController = new TextEditingController();
  final TextEditingController _prenomTextController =
      new TextEditingController();
  final TextEditingController _telephoneTextController =
      new TextEditingController();
  final TextEditingController _passwordTextController =
      new TextEditingController();
  final TextEditingController _nameTextController = new TextEditingController();
  final TextEditingController _comfirmePasswordTextController =
      new TextEditingController();
  final TextEditingController _dateNaissanceTextController =
  new TextEditingController();
  String gender;
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image.asset(
          //   "assets/images/arriere3.jpg",
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          // Container(
          //   alignment: Alignment.topCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 40.0),
          //     child: Image.asset(
          //       "assets/images/book.png",
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      height: 110.0,
                      padding: EdgeInsets.only(bottom: 20.0, top: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Creation de compte",
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "By groupe 2",
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _nomTextController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(EvaIcons.personOutline, color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Style.Colors.mainColor),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "Nom",
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
                      if (value.isEmpty || value == null) {
                        return "Nom est obligatoire";
                      }
                      return null;
                    },
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _prenomTextController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(EvaIcons.personOutline, color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Style.Colors.mainColor),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "Prenom",
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
                      if (value.isEmpty || value == null) {
                        return "prenom est obligatoire";
                      }
                      return null;
                    },
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _emailTextController,
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
                      if (value.isEmpty || value == null) {
                        return "Email est obligatoire";
                      }
                      return null;
                    },
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _telephoneTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(EvaIcons.phoneOutline, color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Style.Colors.mainColor),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "Numero telephone",
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
                      if (value.isEmpty || value == null) {
                        return "Telephone est obligatoire";
                      }
                      else if (value.length < 6)
                        return "Le telephone doit comporter au moins 6 caracters";
                      return null;
                    },
                    autocorrect: false,
                  )
                  ,
                  SizedBox(
                    height: 20.0,
                  ),
                  DateTimeField(
                    format: format,
                    onShowPicker: (context, currentValue){
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _dateNaissanceTextController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon:
                      Icon(EvaIcons.calendar, color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Style.Colors.mainColor),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "Date de naissance",
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
                      if (value == null) {
                        return "Date de naissance obligatoire";
                      }

                      return null;
                    },
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold),
                    controller: _passwordTextController,
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
                      if (value.isEmpty || value == null)
                        return "mot de passe obligatoire";
                      else if (value.length < 6)
                        return "mot de passe doit avoir minimum 6 caracteres";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('creation...'),));
                                    Loader.show(context,
                                      progressIndicator: CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                      ),);

                                    Future.delayed(Duration(seconds: 5), () {
                                      Loader.hide();
                                    });
                                    bool message = false;
                                    message =await login(_nomTextController.text,_prenomTextController.text,_emailTextController.text,
                                        _telephoneTextController.text,_dateNaissanceTextController.text,_passwordTextController.text);

                                    print(message);
                                    if (message){
                                      //await storage.write(key: "token", value: message);
                                      Navigator.pushReplacement(context,
                                          new MaterialPageRoute(builder: (context)=> new Login()));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la creation de compte'),));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Remplir tout les champs'),));
                                  }

                                },
                                child: Text("Creer",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new Login()));
                                  },
                                  child: Text(
                                    "Connexion",
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
          ),
        ],
      ),
    );
  }
}

Future<bool> login(String nom, String prenom, String email, String phone, String dateN, String password, ) async {
  final Uri baseUrl =
  Uri.parse("https://api-ccnb-gestion-notes.herokuapp.com/api/user/register");
  var response = await http.post(baseUrl, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "nom" : nom,
    "prenom": prenom,
    "telephone": phone,
    "date_naissance": dateN,
    "email": email,
    "password": password
  });
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    return true;
  }
  else {
    print(response.body);
    return false;
  }
}