import 'package:flutter/material.dart';
import 'package:gestion_notes/pages/intro_screen.dart';
import 'package:gestion_notes/pages/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
  ));
}
