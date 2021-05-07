import 'package:flutter/material.dart';

class CoursDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Voulez vous vraiment supprimez ce cours ?'),
      actions: [
        FlatButton(onPressed: (){
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
