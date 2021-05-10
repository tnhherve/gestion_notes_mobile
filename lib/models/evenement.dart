// To parse this JSON data, do
//
//     final evenementResponse = evenementResponseFromJson(jsonString);

import 'dart:convert';

EvenementResponse evenementResponseFromJson(String str) => EvenementResponse.fromJson(json.decode(str));

String evenementResponseToJson(EvenementResponse data) => json.encode(data.toJson());

class EvenementResponse {
  EvenementResponse({
    this.status,
    this.length,
    this.data,
  });

  bool status;
  int length;
  List<Evenement> data;

  factory EvenementResponse.fromJson(Map<String, dynamic> json) => EvenementResponse(
    status: json["status"],
    length: json["length"],
    data: List<Evenement>.from(json["data"].map((x) => Evenement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "length": length,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Evenement {
  Evenement({
    this.id,
    this.userId,
    this.nomEvenement,
    this.dateDebut,
    this.dateFin,
    this.lieux,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String nomEvenement;
  DateTime dateDebut;
  DateTime dateFin;
  String lieux;
  DateTime createdAt;
  DateTime updatedAt;

  factory Evenement.fromJson(Map<String, dynamic> json) => Evenement(
    id: json["id"],
    userId: json["user_id"],
    nomEvenement: json["nom_evenement"],
    dateDebut: DateTime.parse(json["date_debut"]),
    dateFin: DateTime.parse(json["date_fin"]),
    lieux: json["lieux"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "nom_evenement": nomEvenement,
    "date_debut": dateDebut.toIso8601String(),
    "date_fin": dateFin.toIso8601String(),
    "lieux": lieux,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
