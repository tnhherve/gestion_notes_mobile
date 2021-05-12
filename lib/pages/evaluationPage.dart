import 'package:flutter/material.dart';
import 'package:gestion_notes/controllers/evaluationController.dart';
import 'package:get/get.dart';

class EvaluationPage extends StatefulWidget {
  final int idCours;

  const EvaluationPage({Key key, this.idCours}):super(key: key);


  //EvaluationPage({this.idCours});

  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  EvaluationController _evaluationController = Get.put(EvaluationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _evaluationController.getEvaluationsCours(widget.idCours);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluations"),

      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Obx(()=> ListView.builder(
          itemCount: _evaluationController.evaluations.value.data.length,
          itemBuilder: (context, index){
            return Card(
              child: Dismissible(
                direction: DismissDirection.startToEnd,
                key: ValueKey(_evaluationController.evaluations.value.data[index]),
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
                  leading: Image.asset("assets/images/cours.png", height: 70, ),
                  title: Text(_evaluationController.evaluations.value.data[index].titre),
                  subtitle: Text(_evaluationController.evaluations.value.data[index].note),
                  isThreeLine: true,
                  onTap: (){

                  },
                ),
              ),
            );
          })
        ),
      )
    );
  }
}