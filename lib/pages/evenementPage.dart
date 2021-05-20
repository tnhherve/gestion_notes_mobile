import 'package:flutter/material.dart';
import 'package:gestion_notes/components/EventDelete.dart';
import 'package:gestion_notes/controllers/evenementController.dart';
import 'package:gestion_notes/pages/addEvent.dart';
import 'package:get/get.dart';

class EvenementPage extends StatefulWidget {
  @override
  _EvenementPageState createState() => _EvenementPageState();
}

class _EvenementPageState extends State<EvenementPage> {

  EvenementController _evenementController=Get.put(EvenementController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    _evenementController.getEvenementUser();
    // data = (_evenementController.evenements.value == null)?null:_evenementController.evenements.value.data.obs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Evenements"),),
      body: Container(
          padding: EdgeInsets.all(8),
          child: Obx(()=> (_evenementController.evenements.value.data == null)?Container(child: Center(child: Text("empty"),),):ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _evenementController.evenements.value.data.length,
              itemBuilder: (context, index){
                return Card(
                  child: Dismissible(
                    key: ValueKey(_evenementController.evenements.value.data[index]),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) async {
                      bool delete = await _evenementController.deleteEvent(_evenementController.evenements.value.data[index].id);
                      if (delete) {
                        await _evenementController.getEvenementUser();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Evenement ${_evenementController.evenements.value.data[index].nomEvenement} supprimer'),));
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Erreur lors de la suppression'),));
                      }

                    },
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => EventDelete());
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
                      leading: Image.asset("assets/images/event.png",height: 70,),
                      title: Text(_evenementController.evenements.value.data[index].nomEvenement),
                      subtitle: Text("\n${_evenementController.evenements.value.data[index].dateDebut}\n${_evenementController.evenements.value.data[index].dateFin}"),
                      //isThreeLine: true,
                      onTap: (){
                        print("echo");
                      },
                    ),
                  ),
                );
              }),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEvent()));
        },
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        label: Text("Ajouter"),
      ),
    );
  }
}