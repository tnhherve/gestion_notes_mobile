import 'package:flutter/material.dart';
import 'package:gestion_notes/controllers/coursController.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class CoursDelete extends StatelessWidget {

  CoursController _coursController = Get.put(CoursController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Voulez vous vraiment supprimez ce cours ?'),
      actions: [
        FlatButton(onPressed: () async {
          await _coursController.fetchUserCourses();
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
