import 'package:flutter/material.dart';
import 'package:gestion_notes/controllers/evenementController.dart';
import 'package:get/get.dart';

class EvenementPage extends StatefulWidget {
  @override
  _EvenementPageState createState() => _EvenementPageState();
}

class _EvenementPageState extends State<EvenementPage> {

  EvenementController _evenementController=Get.put(EvenementController());
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    _evenementController.getEvenementUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Evenements"),),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Obx(()=> ListView.builder(
          padding: const EdgeInsets.all(5.0),
            itemCount: _evenementController.evenements.value.data.length,
            itemBuilder: (context, index){
            return Card(
              child: Dismissible(
                key: ValueKey(_evenementController.evenements.value.data[index]),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {

                },
                confirmDismiss: (direction) {
                  
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
                  leading: Image.asset("assets/images/book.png",height: 70,),
                  title: Text(_evenementController.evenements.value.data[index].nomEvenement),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                  onTap: (){
                    print("echo");
                  },
                ),
              ),
            );
          }),
        )
      ),
    );
  }
}
