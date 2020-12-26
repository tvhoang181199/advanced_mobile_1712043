import 'package:DARKEN/Models/CourseModelOffline.dart';
import 'package:flutter/material.dart';

class ListCoursesModelOffline extends ChangeNotifier {

  final List<CourseModelOffline> _listCourses = [
    CourseModelOffline.short('00', 'Mobile Testing with Appium', 'Testing with Appium Description', 12, 'assets/Courses/appium-1.png', 'HTThanh', 0, List.filled(12, false)),
    CourseModelOffline.short('01', 'Golang Basic', 'Golang Basic Description', 6, 'assets/Courses/golang-1.png', 'TMTriet', 0, List.filled(6, false)),
    CourseModelOffline.short('02', 'Java Basic', 'Java Basic Description', 22, 'assets/Courses/java-1.png', 'PHHai', 0, List.filled(22, false)),
    CourseModelOffline.short('03', 'Game development with Unity', 'Game development with Unity Description', 15, 'assets/Courses/unity-1.jpg', 'NLHDung', 0, List.filled(15, false)),
    CourseModelOffline.short('04', 'Swift Basic', 'Swift Basic Description', 20, 'assets/Courses/swift-1.png', 'NLHDung', 0, List.filled(20, false)),
    CourseModelOffline.short('05', 'Python Basic', 'Python Basic Description', 12, 'assets/Courses/python-1.jpg', 'KMCanh', 0, List.filled(12, false)),
    CourseModelOffline.short('06', 'Python Advanced', 'Python Advanced Description', 16, 'assets/Courses/python-2.jpg', 'KMCanh', 0, List.filled(16, false)),
    CourseModelOffline.short('07', 'Flutter Basic', 'Flutter Basic Description', 26, 'assets/Courses/flutter-1.png', 'PHHai', 0, List.filled(26, false)),
    CourseModelOffline.short('08', 'C# Basic', 'C# Basic Description', 24, 'assets/Courses/csharp-1.jpg', 'TADuy', 0, List.filled(24, false)),
    CourseModelOffline.short('09', 'Facebook Ads', 'Facebook Ads Description', 14, 'assets/Courses/fb-ads-1.png', 'PHHai', 0, List.filled(14, false)),
    CourseModelOffline.short('10', 'Google Ads', 'Google Ads Description', 11, 'assets/Courses/google-ads-1.png', 'PHHai', 0, List.filled(11, false)),
    CourseModelOffline.short('11', 'Digital Marketing Basic', 'Digital Marketing Basic Description', 8, 'assets/Courses/digital-marketing-1.jpg', 'PHHai', 0, List.filled(8, false)),
  ];
  final List<CourseModelOffline> _downloadedListCourses = [];

  List<CourseModelOffline> get listCourses => _listCourses;
  List<CourseModelOffline> get downloadedListCourses => _downloadedListCourses;

  void addDownloaded(CourseModelOffline course, int index) {
    if (course.downloadedVideos == 0) {
      _downloadedListCourses.add(course);
    }
    _listCourses.singleWhere((_course) => _course.id == course.id).downloadedVideos++;
    _listCourses.singleWhere((_course) => _course.id == course.id).downloadedVideosList[index] = true;
    notifyListeners();
  }

  void removeDownloaded(CourseModelOffline course, int index) {
    if (course.downloadedVideos == 1) {
      _downloadedListCourses.removeWhere((_course) => _course.id == course.id);
    }
    _listCourses.singleWhere((_course) => _course.id == course.id).downloadedVideos--;
    _listCourses.singleWhere((_course) => _course.id == course.id).downloadedVideosList[index] = false;
    notifyListeners();
  }

  void add(CourseModelOffline course) {
    _listCourses.add(course);
    notifyListeners();
  }

  void removeAll() {
    _listCourses.clear();
    notifyListeners();
  }
}