// To parse this JSON data, do
//
//     final ponderation = ponderationFromJson(jsonString);

import 'dart:convert';

Ponderation ponderationFromJson(String str) => Ponderation.fromJson(json.decode(str));

String ponderationToJson(Ponderation data) => json.encode(data.toJson());

class Ponderation {
  Ponderation({
    this.sommePonderationEvaluation,
  });

  String sommePonderationEvaluation;

  factory Ponderation.fromJson(Map<String, dynamic> json) => Ponderation(
    sommePonderationEvaluation: json["somme_ponderation_evaluation"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "somme_ponderation_evaluation": sommePonderationEvaluation,
  };
}
