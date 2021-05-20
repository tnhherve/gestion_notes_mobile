
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_notes/models/cours.dart';
import 'package:gestion_notes/models/evaluation.dart';
import 'package:gestion_notes/models/evenement.dart';
import 'package:gestion_notes/models/ponderation.dart';
import 'package:gestion_notes/models/typeEvaluation.dart';
import 'package:gestion_notes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class API_Manager {

  final String BASE_URL = "https://api-ccnb-gestion-notes.herokuapp.com/api";

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var  token= prefs.getString('token');
    if(token != null)
      return token;
    else
      return "";
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<void> writeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token',token);
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

  Future<CoursResponse> getUserCourses() async {
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
    var cours = null;

    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      //print(jsonMap);
      cours = CoursResponse.fromJson(jsonMap);
      //print(cours);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return cours;
  }

  Future<Cours> deleteCours(int id) async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/cours/${id}");
    var response = await http.delete(
        baseUrl,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    var cours = null;
    print(response.statusCode);
    print("${baseUrl}/${await getToken()}");
    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
      cours = Cours.fromJson(jsonMap['data']);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return cours;
  }

  Future<bool> addCours(String nomC, String section, double seuil) async{
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/cours");
    var response = await http.post(
        baseUrl,
        body: {
          "nom_cours":nomC,
          "section_id": section,
          "seuil_reussite": seuil.toString()
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    bool cours = false;
  print("${baseUrl}/${await getToken()}");
    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
      cours = true;
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return cours;
  }

  Future<Ponderation> getSumPonderationCours(int id) async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/cours/${id}/ponderation");
    var response = await http.get(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    var ponderation = null;

    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      //print(jsonMap);
      ponderation = Ponderation.fromJson(jsonMap);
      //print(cours);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return ponderation;
  }

  Future<EvaluationResponse> getEvaluationsCours(int id) async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/cours/${id}/evaluations");
    var response = await http.get(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    var evaluations = null;

    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);

      evaluations = EvaluationResponse.fromJson(jsonMap);
      //print(cours);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return evaluations;
  }

  Future<EvenementResponse> getEvenementUser() async{
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/evenements");
    var response = await http.get(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    var evenements = null;

    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      //print(jsonMap);
      evenements = EvenementResponse.fromJson(jsonMap);
      //print(cours);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return evenements;
  }

  Future<bool> addEvent(String nom, String lieu, String dateD, String dateF) async{
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/user/evenements");
    var response = await http.post(
        baseUrl,
        body: {
          "nom_evenement": nom,
          "date_debut": dateD,
          "date_fin": dateF,
          "lieux": lieu
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    bool etat = false;
    print("${baseUrl}/${await getToken()}");
    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
      etat = true;
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return etat;
  }

  Future<Evenement> deleteEvent(int id) async {
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/evenements/${id}");
    var response = await http.delete(
        baseUrl,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    var event = null;
    print(response.statusCode);
    print("${baseUrl}/${await getToken()}");
    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
      event = Evenement.fromJson(jsonMap['data']);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return event;
  }

  Future<bool> addEvaluation(String titre, double note, double ponderation, String dateE, String typeE, int coursId) async{
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/evaluations");
    var response = await http.post(
        baseUrl,
        body: {
          "titre": titre,
          "note": note.toString(),
          "ponderation": ponderation.toString(),
          "date_evaluation": dateE,
          "type_evaluation": typeE,
          "cours_id": coursId.toString()
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    bool eval = false;
    print("${baseUrl}/${await getToken()}");
    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
      eval = true;
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return eval;
  }

  Future<TypeEvaluationResponse> getTypeEvaluation() async{
    final Uri baseUrl =
    Uri.parse(BASE_URL+"/typeEvaluations");
    var response = await http.get(
        baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${await getToken()}",
        }
    );
    var type = null;

    if (response.statusCode == 200){
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      //print(jsonMap);
      type = TypeEvaluationResponse.fromJson(jsonMap);
      //print(cours);
    }
    else{
      var jsonString = response.body;
      var jsonMap = convert.jsonDecode(jsonString);
      print(jsonMap);
    }

    return type;
  }

}