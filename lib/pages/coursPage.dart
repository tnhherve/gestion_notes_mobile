import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gestion_notes/components/CoursDelete.dart';
import 'package:gestion_notes/controllers/coursController.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {

  CoursController _coursController = Get.put(CoursController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nomCoursTextEditingController = TextEditingController();
  TextEditingController _sectionTextEditingController = TextEditingController();
  TextEditingController _seuilTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coursController.fetchUserCourses();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cours"),),
      body: Container(
          padding: EdgeInsets.all(8),
          child: Obx(()=> ListView.builder(
            padding: const EdgeInsets.all(5.0),
              itemCount: _coursController.coursList.value.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Dismissible(
                    key: ValueKey(_coursController.coursList.value.data[index].id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) async {
                      bool delete = await _coursController.deleteCours(_coursController.coursList.value.data[index].id);
                      if (delete) {
                        await _coursController.fetchUserCourses();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'cours ${_coursController.coursList.value
                                  .data[index].nomCours} supprimer'),));
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Erreur lors de la suppression'),));
                      }

                    },
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => CoursDelete());
                      print(result);
                      return result;
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/images/book.png", height: 70, ),
                      title: Text(_coursController.coursList.value.data[index].nomCours),
                      subtitle: Text("Seuil de reussite: ${_coursController.coursList.value.data[index].seuilReussite}%"),
                      trailing: Icon(Icons.more_vert),
                      isThreeLine: true,
                      onTap: (){
                        print("echo");
                      },
                    ),
                  )
                );
              }),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showForm(context);
        },
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        label: Text("Ajouter"),
      ),
    );
  }
  Future<Widget> showForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Container(padding: EdgeInsets.only(bottom: 5), child: Text('Ajouter un Cours')),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon:
                          Icon(EvaIcons.book, color: Colors.black26),
                          enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              new BorderSide(color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "Nom Cours",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: _nomCoursTextEditingController,

                        validator: (value) {
                          return value.isNotEmpty ? null : "Entrer le nom du cours";
                        },

                      ),

                      SizedBox(
                        height: 5.0,
                      ),
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
                          labelText: "Section (1-Automne, 2-Hiver, 3-Printemps)",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: _sectionTextEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Entrer la section (1-Automne, 2-Hiver, 3-Printemps)";
                        },

                      ),
                      SizedBox(
                        height: 5.0,
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
                          labelText: "Seuil reussite",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: _seuilTextEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Entrer le seuil de reussite";
                        },

                      ),

                    ],
                  )),

              actions: <Widget>[

                Center(
                  child: RaisedButton(
                      child: Text("Enregistrer"),
                      color: Colors.blue,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          double seuil = double.parse(_seuilTextEditingController.text);

                          bool response = await _coursController.addCours(_nomCoursTextEditingController.text,
                              _sectionTextEditingController.text, seuil);

                          if (response){

                            Loader.show(context,
                              progressIndicator: CircularProgressIndicator(
                                backgroundColor: Colors.red,
                              ),);

                            Future.delayed(Duration(seconds: 3), () {
                              Loader.hide();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enregistrer avec succes'),));
                            _coursController.fetchUserCourses();
                          }else{
                            Loader.show(context,
                              progressIndicator: CircularProgressIndicator(
                                backgroundColor: Colors.red,
                              ),);

                            Future.delayed(Duration(seconds: 5), () {
                              Loader.hide();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la creation du cours'),));
                          }
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> CoursPage()));
                        }
                      }
                  ),
                )
              ],
            );
          });
        });
  }
}


