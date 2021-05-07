// To parse this JSON data, do
//
//     final coursResponse = coursResponseFromJson(jsonString);

import 'dart:convert';

CoursResponse coursResponseFromJson(String str) => CoursResponse.fromJson(json.decode(str));

String coursResponseToJson(CoursResponse data) => json.encode(data.toJson());

class CoursResponse {
  CoursResponse({
    this.status,
    this.data,
  });

  bool status;
  List<Cours> data;

  factory CoursResponse.fromJson(Map<String, dynamic> json) => CoursResponse(
    status: json["status"],
    data: List<Cours>.from(json["data"].map((x) => Cours.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Cours {
  Cours({
    this.id,
    this.userId,
    this.sectionId,
    this.nomCours,
    this.seuilReussite,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int sectionId;
  String nomCours;
  String seuilReussite;
  DateTime createdAt;
  DateTime updatedAt;

  factory Cours.fromJson(Map<String, dynamic> json) => Cours(
    id: json["id"],
    userId: json["user_id"],
    sectionId: json["section_id"],
    nomCours: json["nom_cours"],
    seuilReussite: json["seuil_reussite"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "section_id": sectionId,
    "nom_cours": nomCours,
    "seuil_reussite": seuilReussite,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
