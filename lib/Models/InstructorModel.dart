import 'package:flutter/material.dart';
import 'dart:convert';

InstructorModel InstructorModelFromJson(String str) => InstructorModel.fromJson(json.decode(str));

String InstructorModelToJson(InstructorModel data) => json.encode(data.toJson());

class InstructorModel extends ChangeNotifier {
  InstructorModel({
    this.id,
    this.userId,
    this.userEmail,
    this.userAvatar,
    this.userName,
    this.major,
    this.intro,
    this.skills,
    this.cumulativeTuition,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String userId;
  String userEmail;
  String userAvatar;
  String userName;
  String major;
  String intro;
  List<String> skills;
  int cumulativeTuition;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
    id: json["id"],
    userId: json["userId"],
    userEmail: json["user.email"],
    userAvatar: json["user.avatar"],
    userName: json["user.name"],
    major: json["major"],
    intro: json["intro"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    cumulativeTuition: json["cumulativeTuition"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "user.email": userEmail,
    "user.avatar": userAvatar,
    "user.name": userName,
    "major": major,
    "intro": intro,
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "cumulativeTuition": cumulativeTuition,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}




