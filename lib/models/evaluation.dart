// To parse this JSON data, do
//
//     final evaluationResponse = evaluationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_notes/models/cours.dart';

EvaluationResponse evaluationResponseFromJson(String str) => EvaluationResponse.fromJson(json.decode(str));

String evaluationResponseToJson(EvaluationResponse data) => json.encode(data.toJson());

class EvaluationResponse {
  EvaluationResponse({
    this.status,
    this.totalEvaluation,
    this.totalNote,
    this.moyenne,
    this.cours,
    this.data,
  });

  bool status;
  int totalEvaluation;
  int totalNote;
  double moyenne;
  Cours cours;
  List<Evaluation> data;

  factory EvaluationResponse.fromJson(Map<String, dynamic> json) => EvaluationResponse(
    status: json["status"],
    totalEvaluation: json["total_evaluation"],
    totalNote: json["total_note"],
    moyenne: json["moyenne"],
    cours: Cours.fromJson(json["cours"]),
    data: List<Evaluation>.from(json["data"].map((x) => Evaluation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_evaluation": totalEvaluation,
    "total_note": totalNote,
    "moyenne": moyenne,
    "cours": cours.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Evaluation {
  Evaluation({
    this.id,
    this.typeEvaluationId,
    this.coursId,
    this.titre,
    this.typeEvaluation,
    this.note,
    this.ponderation,
    this.dateEvaluation,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int typeEvaluationId;
  int coursId;
  String titre;
  String typeEvaluation;
  String note;
  String ponderation;
  DateTime dateEvaluation;
  DateTime createdAt;
  DateTime updatedAt;

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
    id: json["id"],
    typeEvaluationId: json["type_evaluation_id"],
    coursId: json["cours_id"],
    titre: json["titre"],
    typeEvaluation: json["type_evaluation"],
    note: json["note"],
    ponderation: json["ponderation"],
    dateEvaluation: DateTime.parse(json["date_evaluation"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_evaluation_id": typeEvaluationId,
    "cours_id": coursId,
    "titre": titre,
    "type_evaluation": typeEvaluation,
    "note": note,
    "ponderation": ponderation,
    "date_evaluation": dateEvaluation.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
