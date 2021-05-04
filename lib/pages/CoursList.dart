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
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Card(child: Column(
                children: <Widget>[ // Ajout des items dnas les card
                  Text(todos[index].title),
                  Text(todos[index].description)
                ],
              ),),
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

