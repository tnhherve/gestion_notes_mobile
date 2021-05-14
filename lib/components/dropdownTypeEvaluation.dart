
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class DropDownTypeEvaluation extends StatefulWidget {
  @override
  _DropDownTypeEvaluationState createState() => _DropDownTypeEvaluationState();
}

class _DropDownTypeEvaluationState extends State<DropDownTypeEvaluation> {

  String dropdownValue = "Test";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        elevation: 26,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 3,
          color: Colors.deepPurple,
        ),
        onChanged: (String newValue){
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Test','one','two']
          .map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
        }).toList(),
    );
  }
}
