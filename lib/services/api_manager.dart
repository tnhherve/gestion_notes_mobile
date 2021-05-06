import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_notes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class API_Manager {

  final String BASE_URL = "https://api-ccnb-gestion-notes.herokuapp.com/api";

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var  token= prefs.getString('token');
    return token;
  }

  Future<String> login(String email, String password) async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/login");
    var response = await http.post(
        baseUrl,
        headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": email,
          "password": password
        });

    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("success");
      return jsonResponse['access_token'];
    }
    else if (response.statusCode == 401) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("Erreur");
      print(jsonResponse);
      return jsonResponse['error'];
    }else{
      //var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("Erreur");
     // print(baseUrl);

    }
  }

  Future<bool> register(String nom, String prenom, String email, String phone, String dateN, String password, ) async {
    final Uri baseUrl =
    Uri.parse("https://api-ccnb-gestion-notes.herokuapp.com/api/user/register");
    var response = await http.post(baseUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      "nom" : nom,
      "prenom": prenom,
      "telephone": phone,
      "date_naissance": dateN,
      "email": email,
      "password": password
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    else {
      print(baseUrl);
      return false;
    }
  }

  Future<User>getUser(String token) async{
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/profile");
    var response = await http.get(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token}",
        }
    );
    var user = null;
    print(response.statusCode);
    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);

      user = User.fromJson(jsonMap);
      print(user);
    }
    else{
      var jsonString = response.body;

     // print(jsonString);
    }

    return user;
  }

  Future<Void> getUserCourses() async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/cours");
    var response = await http.get(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );

    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
      print(baseUrl);
      print(await getToken());
    }
    else{
      var jsonString = response.body;
      print(jsonString);
    }
  }

  Future<bool> logout(String token) async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/logout");
    var response = await http.post(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token}",
        }
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    else {
      print(baseUrl);
      return false;
    }
  }

}