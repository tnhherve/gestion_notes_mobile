import 'package:flutter/material.dart';
import 'package:gestion_notes/components/CoursDelete.dart';
import 'package:gestion_notes/controllers/coursController.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {

  CoursController _coursController = Get.put(CoursController());

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
                    onDismissed: (direction) {},
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
                      leading: Image.asset("assets/images/board.png", height: 70, ),
                      title: Text(_coursController.coursList.value.data[index].nomCours),
                      subtitle: Text("${_coursController.coursList.value.data[index].seuilReussite}%"),
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

        },
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        label: Text("Ajouter"),
      ),
    );
  }
}
