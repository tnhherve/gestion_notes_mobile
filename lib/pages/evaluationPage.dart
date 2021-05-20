import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_notes/controllers/evaluationController.dart';
import 'package:gestion_notes/models/evaluation.dart';
import 'package:gestion_notes/pages/addEvaluation.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class EvaluationPage extends StatefulWidget {
  final int idCours;

  const EvaluationPage({Key key, this.idCours}):super(key: key);


  //EvaluationPage({this.idCours});

  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  EvaluationController _evaluationController = Get.put(EvaluationController());

  List _elements = [
    {'name': 'John', 'group': 'Team A'},
    {'name': 'Will', 'group': 'Team B'},
    {'name': 'Beth', 'group': 'Team A'},
    {'name': 'Miranda', 'group': 'Team B'},
    {'name': 'Mike', 'group': 'Team C'},
    {'name': 'Danny', 'group': 'Team C'},
  ];
  List eval = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.idCours);
    _evaluationController.getEvaluationsCours(widget.idCours);
    var evalu = _evaluationController.evaluations.value.data;
    // for(var i = 0; i < evalu.length; i++){
    //   this.eval.add(evalu[i]);
    // }

    _elements = jsonDecode(jsonEncode(evalu));
    print(_elements);
    //print(jsonDecode(jsonEncode(evalu)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluations"),

      ),
       body: ListView(
        children: [
          // Container(
          //   height: 50,
          //   width: 100,
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 10,
          //     child: Center(
          //       child: Text((_evaluationController.evaluations.value.data.isEmpty?"0":"Moyenne: "+_evaluationController.evaluations.value.moyenne.toString()), style: TextStyle(fontSize: 20),),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text("liste des evaluations", style: TextStyle(fontWeight: FontWeight.bold),)),
          ),
          (_elements == null)?Container(child: Center(child: Text("Empty"),),):GroupedListView<dynamic, String>(
            elements: _elements,
            groupBy: (element) => element['type_evaluation'],
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1['titre'].compareTo(item2['titre']),
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            shrinkWrap: true,
            itemBuilder: (c, element) {
              return Card(
                child: Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: ValueKey(element),
                  onDismissed: (direction){

                  },
                  confirmDismiss: (direction){

                  },
                  background: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.red,
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white,),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset("assets/images/evaluations.png", height: 100, ),
                    title: Text(element['titre']),
                    subtitle: Text("\n"+
                        "Pond: "+element['ponderation']+"%"),
                    isThreeLine: true,
                    dense: false,
                    trailing: Text(
                      element['note']+"%",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              );
            },
          ),

          // Container(
          //   padding: EdgeInsets.all(8.0),
          //   child: (_evaluationController.evaluations.value.data.isEmpty)?Center(child: Text("Empty")):Obx(()=> ListView.builder(
          //       shrinkWrap: true,
          //       physics: ScrollPhysics(),
          //       padding: const EdgeInsets.all(5.0),
          //       itemCount: _evaluationController.evaluations.value.data.length,
          //       itemBuilder: (context, index){
          //         return Card(
          //           child: Dismissible(
          //             direction: DismissDirection.startToEnd,
          //             key: ValueKey(_evaluationController.evaluations.value.data[index]),
          //             onDismissed: (direction){
          //
          //             },
          //             confirmDismiss: (direction){
          //
          //             },
          //             background: Container(
          //               padding: EdgeInsets.all(16.0),
          //               color: Colors.red,
          //               child: Align(
          //                 child: Icon(Icons.delete, color: Colors.white,),
          //                 alignment: Alignment.centerLeft,
          //               ),
          //             ),
          //             child: ListTile(
          //               leading: Image.asset("assets/images/evaluations.png", height: 100, ),
          //               title: Text(_evaluationController.evaluations.value.data[index].titre),
          //               subtitle: Text("\n"+
          //                   "Pond: "+_evaluationController.evaluations.value.data[index].ponderation+"%"),
          //               isThreeLine: true,
          //               dense: false,
          //               trailing: Text(
          //                 _evaluationController.evaluations.value.data[index].note+"%",
          //                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          //               ),
          //               onTap: (){
          //
          //               },
          //             ),
          //           ),
          //         );
          //       })
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Get.to(AddEvaluationPage(idCours: widget.idCours));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context)=> AddEvaluationPage(idCours: widget.idCours,) ));
        },
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        label: Text("Ajouter"),
      ),
    );
  }
}
