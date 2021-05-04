import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/UserInfo.dart';
import 'package:flutter_app/NotesList.dart';

import 'NotesList.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class CoursList extends StatelessWidget
{
  final todos = List<Todo>.generate(
    20,
        (i) => Todo(
      'Cours $i',
      'Description du cours $i',
    ),
  );

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text("Classes"),
          actions: <Widget>[
            Material(
              elevation: 4.0,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: Ink.image(
                image: AssetImage('assets/images/download.jpg'),
                fit: BoxFit.cover,
                width: 80.0,
                height: 120.0,
                child: InkWell(
                  onTap: () {    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => UserInfo()),
                  );},
                ),
              ),
            )
          ],
        ),
        body:
        ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              // When a user taps the ListTile, navigate to the DetailScreen.
              // Notice that you're not only creating a DetailScreen, you're
              // also passing the current todo to it.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesList(todo: todos[index]),),
                );
              },
            );
          },
        ),
      );

  }
}

