import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gestion_notes/controllers/evenementController.dart';
import 'package:gestion_notes/pages/evenementPage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  EvenementController _evenementController = Get.put(EvenementController());

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();

  TextEditingController _nomTextEditingController = new TextEditingController();
  TextEditingController _lieuTextEditingController = new TextEditingController();
  final TextEditingController _dateDTextController = new TextEditingController();
  final TextEditingController _dateFTextController = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajout un evenement"),),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _oFormKey,
            child: ListView(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.text, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Nom evenement",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  controller: _nomTextEditingController,

                  validator: (value) {
                    return value.isNotEmpty ? null : "Entrer le nom de l'evenement";
                  },

                ),

                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.map, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Lieu",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  controller: _lieuTextEditingController,
                  validator: (value) {
                    return value.isNotEmpty ? null : "Entrer le lieu";
                  },

                ),
                SizedBox(
                  height: 30.0,
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
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                  controller: _dateDTextController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.calendar, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Date debut",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Date debut obligatoire";
                    }

                    return null;
                  },
                  autocorrect: false,
                ),
                SizedBox(
                  height: 30.0,
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
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                  controller: _dateFTextController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.calendar, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Date de fin",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Date fin obligatoire";
                    }

                    return null;
                  },
                  autocorrect: false,
                ),


                SizedBox(
                  height: 30.0,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                          height: 45,
                          child: RaisedButton(
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              disabledTextColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPressed: () async {

                                if (_oFormKey.currentState.validate()){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('creation...'),));
                                  Loader.show(context,
                                    progressIndicator: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                    ),);

                                  Future.delayed(Duration(seconds: 5), () {
                                    Loader.hide();
                                  });
                                  bool message = false;
                                  var nom = _nomTextEditingController.text;
                                  var lieu = _lieuTextEditingController.text;
                                  var dateD = _dateDTextController.text;
                                  var dateF = _dateFTextController.text;


                                  message = await _evenementController.addEvent(nom, lieu, dateD, dateF);

                                  print(message);
                                  if (message){
                                    //_evenementController.getEvenementUser();
                                    await Get.off(EvenementPage());
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> EvaluationPage(idCours: widget.idCours,)));
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la creation de l evenement'),));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Remplir tout les champs'),));
                                }

                              },
                              child: Text("Enregistrer",
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)))),
                    ],
                  ),
                ),

              ],
            ),
          )

        )
      ),
    );
  }
}
