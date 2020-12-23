import 'dart:convert';
import 'package:flutter/widgets.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends ChangeNotifier{
  UserModel({
    this.id,
    this.email,
    this.avatar,
    this.name,
    this.favoriteCategories,
    this.phone,
    this.type,
    this.isDeleted,
    this.isActivated,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String email;
  String avatar;
  String name;
  List<String> favoriteCategories;
  String phone;
  String type;
  bool isDeleted;
  bool isActivated;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    avatar: json["avatar"],
    name: json["name"],
    favoriteCategories: List<String>.from(json["favoriteCategories"].map((x) => x)),
    phone: json["phone"],
    type: json["type"],
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
    "phone": phone,
    "type": type,
    "isDeleted": isDeleted,
    "isActivated": isActivated,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  void updateAvatar(String avatar){
    this.avatar = avatar;
    notifyListeners();
  }

  void editName(String str){
    this.name = str;
    notifyListeners();
  }
  void editEmail(String str){
    this.email = str;
    notifyListeners();
  }
  void editPhone(String str){
    this.phone = str;
    notifyListeners();
  }
}