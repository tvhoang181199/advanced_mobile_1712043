import 'dart:convert';

LessonVideoModel lessonVideoModelFromJson(String str) => LessonVideoModel.fromJson(json.decode(str));

String lessonVideoModelToJson(LessonVideoModel data) => json.encode(data.toJson());

class LessonVideoModel {
  LessonVideoModel({
    this.videoUrl,
    this.currentTime,
    this.isFinish,
  });

  String videoUrl;
  dynamic currentTime;
  dynamic isFinish;

  factory LessonVideoModel.fromJson(Map<String, dynamic> json) => LessonVideoModel(
    videoUrl: json["videoUrl"],
    currentTime: json["currentTime"],
    isFinish: json["isFinish"],
  );

  Map<String, dynamic> toJson() => {
    "videoUrl": videoUrl,
    "currentTime": currentTime,
    "isFinish": isFinish,
  };
}
