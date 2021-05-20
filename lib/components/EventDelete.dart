 import 'package:flutter/material.dart';
import 'package:gestion_notes/controllers/evenementController.dart';
import 'package:get/get.dart';

class EventDelete extends StatelessWidget {

  EvenementController _evenementController = Get.put(EvenementController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Voulez vous vraiment supprimez cet evenement ?'),
      actions: [
        FlatButton(onPressed: () async {
          await _evenementController.getEvenementUser();
          Navigator.of(context).pop(true);
        },
            child: Text('Oui')),
        FlatButton(onPressed: (){
          Navigator.of(context).pop(false);
        },
            child: Text('Non'))
      ],
    );
  }
}
