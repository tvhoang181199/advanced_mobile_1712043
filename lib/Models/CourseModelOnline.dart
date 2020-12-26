// To parse this JSON data, do
//
//     final courseModelOnline = courseModelOnlineFromJson(jsonString);

import 'dart:convert';

CourseModelOnline courseModelOnlineFromJson(String str) => CourseModelOnline.fromJson(json.decode(str));

String courseModelOnlineToJson(CourseModelOnline data) => json.encode(data.toJson());

class CourseModelOnline {
  CourseModelOnline({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.videoNumber,
    this.imageUrl,
  });

  String id;
  String title;
  String subtitle;
  String description;
  int videoNumber;
  String imageUrl;


  factory CourseModelOnline.fromJson(Map<String, dynamic> json) => CourseModelOnline(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    videoNumber: json["videoNumber"],
    imageUrl: json["imageUrl"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "videoNumber": videoNumber,
    "imageUrl": imageUrl,

  };
}

// import 'dart:convert';
//
// InstructorModel instructorModelFromJson(String str) => InstructorModel.fromJson(json.decode(str));
//
// String instructorModelToJson(InstructorModel data) => json.encode(data.toJson());
//
// class InstructorModel {
//   InstructorModel({
//     this.id,
//     this.title,
//     this.subtitle,
//     this.price,
//     this.description,
//     this.requirement,
//     this.learnWhat,
//     this.soldNumber,
//     this.ratedNumber,
//     this.videoNumber,
//     this.totalHours,
//     this.formalityPoint,
//     this.contentPoint,
//     this.presentationPoint,
//     this.imageUrl,
//     this.promoVidUrl,
//     this.status,
//     this.isHidden,
//     this.isDeleted,
//     this.createdAt,
//     this.updatedAt,
//     this.instructorId,
//     this.typeUploadVideoLesson,
//     this.instructorUserId,
//     this.instructorUserName,
//   });
//
//   String id;
//   String title;
//   String subtitle;
//   int price;
//   String description;
//   List<String> requirement;
//   List<String> learnWhat;
//   int soldNumber;
//   int ratedNumber;
//   int videoNumber;
//   double totalHours;
//   double formalityPoint;
//   double contentPoint;
//   int presentationPoint;
//   String imageUrl;
//   String promoVidUrl;
//   String status;
//   bool isHidden;
//   bool isDeleted;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String instructorId;
//   int typeUploadVideoLesson;
//   String instructorUserId;
//   String instructorUserName;
//
//   factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
//     id: json["id"],
//     title: json["title"],
//     subtitle: json["subtitle"],
//     price: json["price"],
//     description: json["description"],
//     requirement: List<String>.from(json["requirement"].map((x) => x)),
//     learnWhat: List<String>.from(json["learnWhat"].map((x) => x)),
//     soldNumber: json["soldNumber"],
//     ratedNumber: json["ratedNumber"],
//     videoNumber: json["videoNumber"],
//     totalHours: json["totalHours"].toDouble(),
//     formalityPoint: json["formalityPoint"].toDouble(),
//     contentPoint: json["contentPoint"].toDouble(),
//     presentationPoint: json["presentationPoint"],
//     imageUrl: json["imageUrl"],
//     promoVidUrl: json["promoVidUrl"],
//     status: json["status"],
//     isHidden: json["isHidden"],
//     isDeleted: json["isDeleted"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     instructorId: json["instructorId"],
//     typeUploadVideoLesson: json["typeUploadVideoLesson"],
//     instructorUserId: json["instructor.user.id"],
//     instructorUserName: json["instructor.user.name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "subtitle": subtitle,
//     "price": price,
//     "description": description,
//     "requirement": List<dynamic>.from(requirement.map((x) => x)),
//     "learnWhat": List<dynamic>.from(learnWhat.map((x) => x)),
//     "soldNumber": soldNumber,
//     "ratedNumber": ratedNumber,
//     "videoNumber": videoNumber,
//     "totalHours": totalHours,
//     "formalityPoint": formalityPoint,
//     "contentPoint": contentPoint,
//     "presentationPoint": presentationPoint,
//     "imageUrl": imageUrl,
//     "promoVidUrl": promoVidUrl,
//     "status": status,
//     "isHidden": isHidden,
//     "isDeleted": isDeleted,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "instructorId": instructorId,
//     "typeUploadVideoLesson": typeUploadVideoLesson,
//     "instructor.user.id": instructorUserId,
//     "instructor.user.name": instructorUserName,
//   };
// }
