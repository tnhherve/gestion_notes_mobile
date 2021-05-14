
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gestion_notes/components/dropdownTypeEvaluation.dart';
import 'package:gestion_notes/controllers/evaluationController.dart';
import 'package:gestion_notes/models/typeEvaluation.dart';
import 'package:gestion_notes/pages/evaluationPage.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddEvaluationPage extends StatefulWidget {
  final int idCours;

  const AddEvaluationPage({Key key, this.idCours}):super(key: key);
  @override
  _AddEvaluationPageState createState() => _AddEvaluationPageState();
}

class _AddEvaluationPageState extends State<AddEvaluationPage> {

  EvaluationController _evaluationController = Get.put(EvaluationController());

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();

  TextEditingController _titreTextEditingController = new TextEditingController();
  TextEditingController _ponderationTextEditingController = new TextEditingController();
  TextEditingController _noteTextEditingController = new TextEditingController();
  final TextEditingController _dateNaissanceTextController = new TextEditingController();
  final TextEditingController _typeTextController = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  TypeEvaluationResponse types = null;
  List<Map<String, dynamic>> _types = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
    ];
  Future<void> getType() async{
    var t = await API_Manager().getTypeEvaluation();
    setState(() {
      print(t.typeEvaluations);
      _types = t.typeEvaluations.cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getType();
    print(_types[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout une evaluation"),
      ),
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
                    labelText: "Titre",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  controller: _titreTextEditingController,

                  validator: (value) {
                    return value.isNotEmpty ? null : "Entrer le titre";
                  },

                ),

                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.percent, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Note",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  controller: _noteTextEditingController,
                  validator: (value) {
                    return value.isNotEmpty ? null : "Entrer la note";
                  },

                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.percent, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Ponderation",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  controller: _ponderationTextEditingController,
                  validator: (value) {
                    return value.isNotEmpty ? null : "Entrer la ponderation";
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
                        new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Date de l'evaluation",
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
                      return "Date de naissance obligatoire";
                    }

                    return null;
                  },
                  autocorrect: false,
                ),
                SizedBox(
                  height: 30.0,
                ),
                //DropDownTypeEvaluation(),

                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(EvaIcons.calendar, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Type Evaluation (1-Test, 2-projet, 3-Devoir)",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  controller: _typeTextController,
                  validator: (value) {
                    return value.isNotEmpty ? null : "Entrer le type d'evaluation";
                  },

                ),
                // SelectFormField(
                //   type: SelectFormFieldType.dropdown,
                //   initialValue: 'circle',
                //   //controller: _typeTextController,
                //   icon: Icon(Icons.arrow_downward),
                //   labelText: "Type d'evaluation",
                //   // changeIcon: true,
                //   // dialogTitle: "Choisir un type d'evaluation",
                //   // dialogCancelBtn: "Annuler",
                //   // enableSearch: true,
                //   // dialogSearchHint: "Search item",
                //   items: _types,
                //   onChanged: (val)=> print(val),
                //   onSaved: (val) => print(val),
                // )

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
                                  var titre = _titreTextEditingController.text;
                                  var note = double.parse(_noteTextEditingController.text);
                                  var ponderation = double.parse(_ponderationTextEditingController.text);
                                  var dateEva = _dateNaissanceTextController.text;
                                  var typeE = int.parse(_typeTextController.text);
                                  var idCours = widget.idCours;
                                  message = await _evaluationController.addEvaluation(titre, note, ponderation, dateEva, typeE, idCours);

                                  print(message);
                                  if (message){
                                    //await storage.write(key: "token", value: message);
                                    Navigator.pushReplacement(context,
                                        new MaterialPageRoute(builder: (context)=> new EvaluationPage(idCours: widget.idCours,)));
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la creation de compte'),));
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
          ),
        ),
      ),
    );
  }
}
