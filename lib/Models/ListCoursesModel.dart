import 'package:DARKEN/Models/CourseModel.dart';
import 'package:flutter/material.dart';

class ListCoursesModel extends ChangeNotifier {

  final List<CourseModel> _listCourses = [
    CourseModel.short('00', 'Mobile Testing with Appium', 'Testing with Appium', 10, 'assets/Courses/appium-1.png'),
    CourseModel.short('01', 'Golang Basic', 'Golang Basic', 10, 'assets/Courses/golang-1.png'),
    CourseModel.short('02', 'Java Basic', 'Java Basic', 10, 'assets/Courses/java-1.png'),
    CourseModel.short('03', 'Game development with Unity', 'Game development with Unity', 10, 'assets/Courses/unity-1.jpg'),
    CourseModel.short('04', 'Swift Basic', 'Swift Basic', 10, 'assets/Courses/swift-1.png'),
    CourseModel.short('05', 'Python Basic', 'Python Basic', 10, 'assets/Courses/python-1.jpg'),
    CourseModel.short('06', 'Python Advanced', 'Python Advanced', 10, 'assets/Courses/python-2.jpg'),
    CourseModel.short('07', 'Flutter Basic', 'Flutter Basic', 10, 'assets/Courses/flutter-1.png'),
    CourseModel.short('08', 'C# Basic', 'C# Basic', 10, 'assets/Courses/csharp-1.jpg'),
    CourseModel.short('09', 'Facebook Ads', 'Facebook Ads', 10, 'assets/Courses/fb-ads-1.png'),
    CourseModel.short('10', 'Google Ads', 'Google Ads', 10, 'assets/Courses/google-ads-1.png'),
    CourseModel.short('11', 'Digital Marketing Basic', 'Digital Marketing Basic', 10, 'assets/Courses/digital-marketing-1.jpg'),
  ];

  List<CourseModel> get listCourses => _listCourses;

  void add(CourseModel course) {
    _listCourses.add(course);
    notifyListeners();
  }

  void removeAll() {
    _listCourses.clear();
    notifyListeners();
  }
}