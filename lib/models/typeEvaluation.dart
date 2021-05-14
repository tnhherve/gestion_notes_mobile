// To parse this JSON data, do
//
//     final typeEvaluationResponse = typeEvaluationResponseFromJson(jsonString);

import 'dart:convert';

TypeEvaluationResponse typeEvaluationResponseFromJson(String str) => TypeEvaluationResponse.fromJson(json.decode(str));

String typeEvaluationResponseToJson(TypeEvaluationResponse data) => json.encode(data.toJson());

class TypeEvaluationResponse {
  TypeEvaluationResponse({
    this.status,
    this.typeEvaluations,
  });

  bool status;
  List<TypeEvaluation> typeEvaluations;

  factory TypeEvaluationResponse.fromJson(Map<String, dynamic> json) => TypeEvaluationResponse(
    status: json["status"],
    typeEvaluations: List<TypeEvaluation>.from(json["TypeEvaluations"].map((x) => TypeEvaluation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "TypeEvaluations": List<dynamic>.from(typeEvaluations.map((x) => x.toJson())),
  };
}

class TypeEvaluation {
  TypeEvaluation({
    this.id,
    this.nomType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nomType;
  DateTime createdAt;
  DateTime updatedAt;

  factory TypeEvaluation.fromJson(Map<String, dynamic> json) => TypeEvaluation(
    id: json["id"],
    nomType: json["nom_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom_type": nomType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
