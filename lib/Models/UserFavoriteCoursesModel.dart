import 'dart:convert';

UserFavoriteCoursesModel favoriteCourseFromJson(String str) => UserFavoriteCoursesModel.fromJson(json.decode(str));

String favoriteCourseToJson(UserFavoriteCoursesModel data) => json.encode(data.toJson());



class UserFavoriteCoursesModel {
  UserFavoriteCoursesModel({
    this.id,
    this.courseTitle,
    // this.coursePrice,
    this.courseImage,
    // this.instructorId,
    this.instructorName,
    // this.courseSoldNumber,
    // this.courseContentPoint,
    // this.courseFormalityPoint,
    // this.coursePresentationPoint,
    // this.courseAveragePoint,
  });

  String id;
  String courseTitle;
  // double coursePrice;
  String courseImage;
  // String instructorId;
 String instructorName;
  // double courseSoldNumber;
  // double courseContentPoint;
  // double courseFormalityPoint;
  // double coursePresentationPoint;
  //double courseAveragePoint;

  factory UserFavoriteCoursesModel.fromJson(Map<String, dynamic> json) => UserFavoriteCoursesModel(
    id: json["id"],
    courseTitle: json["courseTitle"],
    //  coursePrice: json["coursePrice"].toDouble(),
    courseImage: json["courseImage"],
    // instructorId: json["instructorId"],
    instructorName: json["instructorName"],
    // courseSoldNumber: json["courseSoldNumber"].toDouble(),
    // courseContentPoint: json["courseContentPoint"].toDouble(),
    // courseFormalityPoint: json["courseFormalityPoint"].toDouble(),
    // coursePresentationPoint: json["coursePresentationPoint"].toDouble(),
    // courseAveragePoint: json["courseAveragePoint"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseTitle": courseTitle,
    // "coursePrice": coursePrice,
    "courseImage": courseImage,
    // "instructorId": instructorId,
    "instructorName": instructorName,
    // "courseSoldNumber": courseSoldNumber,
    // "courseContentPoint": courseContentPoint,
    // "courseFormalityPoint": courseFormalityPoint,
    // "coursePresentationPoint": coursePresentationPoint,
    // "courseAveragePoint": courseAveragePoint,
  };
}