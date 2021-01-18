import 'dart:convert';

UserProcessCoursesModel userCourseFromJson(String str) => UserProcessCoursesModel.fromJson(json.decode(str));

String userCourseToJson(UserProcessCoursesModel data) => json.encode(data.toJson());

class UserProcessCoursesModel {
  UserProcessCoursesModel({
    this.id,
    this.courseTitle,
    this.courseImage,
    this.instructorId,
    this.instructorName,
    this.latestLearnTime,
    this.total,
    this.learnLesson,
    this.process,
  });

  String id;
  String courseTitle;
  String courseImage;
  String instructorId;
  String instructorName;
  DateTime latestLearnTime;
  double total;
  double learnLesson;
  double process;

  factory UserProcessCoursesModel.fromJson(Map<String, dynamic> json) => UserProcessCoursesModel(
    id: json["id"],
    courseTitle: json["courseTitle"],
    courseImage: json["courseImage"],
    instructorId: json["instructorId"],
    instructorName: json["instructorName"],
    latestLearnTime: DateTime.parse(json["latestLearnTime"]),
    total: json["total"].toDouble(),
    learnLesson: json["learnLesson"].toDouble(),
    process: json["process"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseTitle": courseTitle,
    "courseImage": courseImage,
    "instructorId": instructorId,
    "instructorName": instructorName,
    "latestLearnTime": latestLearnTime.toIso8601String(),
    "total": total,
    "learnLesson": learnLesson,
    "process": process,
  };
}