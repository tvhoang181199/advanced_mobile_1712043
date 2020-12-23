import 'dart:convert';
import 'package:flutter/widgets.dart';

UserMeModel UserMeModelFromJson(String str) => UserMeModel.fromJson(json.decode(str));

String UserMeModelToJson(UserMeModel data) => json.encode(data.toJson());

class UserMeModel extends ChangeNotifier{
  UserMeModel({
    this.message,
    this.payload,
  });

  String message;
  Payload payload;

  factory UserMeModel.fromJson(Map<String, dynamic> json) => UserMeModel(
    message: json["message"],
    payload: Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "payload": payload.toJson(),
  };
}

class Payload {
  Payload({
    this.id,
    this.email,
    this.avatar,
    this.name,
    this.favoriteCategories,
    this.point,
    this.phone,
    this.type,
    this.facebookId,
    this.googleId,
    this.isDeleted,
    this.isActivated,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String email;
  String avatar;
  dynamic name;
  List<dynamic> favoriteCategories;
  int point;
  String phone;
  String type;
  dynamic facebookId;
  dynamic googleId;
  bool isDeleted;
  bool isActivated;
  DateTime createdAt;
  DateTime updatedAt;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    email: json["email"],
    avatar: json["avatar"],
    name: json["name"],
    favoriteCategories: List<dynamic>.from(json["favoriteCategories"].map((x) => x)),
    point: json["point"],
    phone: json["phone"],
    type: json["type"],
    facebookId: json["facebookId"],
    googleId: json["googleId"],
    isDeleted: json["isDeleted"],
    isActivated: json["isActivated"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "avatar": avatar,
    "name": name,
    "favoriteCategories": List<dynamic>.from(favoriteCategories.map((x) => x)),
    "point": point,
    "phone": phone,
    "type": type,
    "facebookId": facebookId,
    "googleId": googleId,
    "isDeleted": isDeleted,
    "isActivated": isActivated,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}