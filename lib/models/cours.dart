// To parse this JSON data, do
//
//     final cours = coursFromJson(jsonString);

import 'dart:convert';

Cours coursFromJson(String str) => Cours.fromJson(json.decode(str));

String coursToJson(Cours data) => json.encode(data.toJson());

class Cours {
  Cours({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory Cours.fromJson(Map<String, dynamic> json) => Cours(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
