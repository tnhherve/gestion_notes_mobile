// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.ecoleId,
    this.email,
    this.emailVerifiedAt,
    this.nom,
    this.prenom,
    this.telephone,
    this.dateNaissance,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  dynamic ecoleId;
  String email;
  dynamic emailVerifiedAt;
  String nom;
  String prenom;
  String telephone;
  DateTime dateNaissance;
  dynamic avatar;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    ecoleId: json["ecole_id"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    nom: json["nom"],
    prenom: json["prenom"],
    telephone: json["telephone"],
    dateNaissance: DateTime.parse(json["date_naissance"]),
    avatar: json["avatar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ecole_id": ecoleId,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "nom": nom,
    "prenom": prenom,
    "telephone": telephone,
    "date_naissance": "${dateNaissance.year.toString().padLeft(4, '0')}-${dateNaissance.month.toString().padLeft(2, '0')}-${dateNaissance.day.toString().padLeft(2, '0')}",
    "avatar": avatar,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
