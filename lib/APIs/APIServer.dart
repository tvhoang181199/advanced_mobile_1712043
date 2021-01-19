import "dart:convert";
import "package:DARKEN/Models/CategoryModel.dart";
import "package:DARKEN/Models/CourseModelOnline.dart";
import 'package:DARKEN/Models/CourseWithLessonModel.dart';
import 'package:DARKEN/Models/ExerciseModel.dart';
import "package:DARKEN/Models/InstructorModel.dart";
import 'package:DARKEN/Models/LessonVideoModel.dart';
import 'package:DARKEN/Models/SearchCourseModel.dart';
import 'package:DARKEN/Models/UserFavoriteCoursesModel.dart';
import 'package:DARKEN/Models/UserProcessCoursesModel.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";
import "package:DARKEN/Models/UserMeModel.dart";
import "Constant-server.dart";

class APIServer{
  // ---- USER ----
  updateToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "token";
    final value = token;
    prefs.setString(key, value);
  }

  updateStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    final _key = key;
    final _value = value;
    prefs.setStringList(key, value);
  }

  Future login(String email, String password) async{
    Map data = {
      "email": email,
      "password": password
    };
    var response = await http.post(api_server + "/user/login",body: data);
    var jsData = jsonDecode(response.body);

    if (response.statusCode == 200){
      final prefs = await SharedPreferences.getInstance();
      updateToken(jsData["token"]);
    }
    return response;
  }

  Future register(String username, String email, String phone, String password) async{
    Map data = {
      "username": username,
      "email": email,
      "phone": phone,
      "password": password
    };
    var response = await http.post(api_server + "/user/register",body: data);
    return response;
  }

  Future forgetPassword(String email) async {
    Map data = {
      "email": email
    };
    var response = await http.post(api_server + "/user/forget-pass/send-email", body: data);
    return response;
  }

  Future<UserMeModel> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token");
    print("token: " + token);
    final response = await http.get(api_server + "/user/me"
        ,headers: {"Authorization": "Bearer $token"}
    );
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      UserMeModel userMe = new UserMeModel.fromJson(responseJson);
      return userMe;
    }
    else {
      return null;
    }
  }

  Future updateUserInfo(String name, String avatar, String phone) async{
    Map data = {
      "name": name,
      "avatar": avatar,
      "phone": phone,
    };
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token");
    final response = await http.put(api_server + "/user/update-profile",headers: {"Authorization": "Bearer $token"}, body: data);
    return response;
  }

  Future changePassword(String id, String oldPassword, String newPassword) async{
    Map data = {
      "id" :id,
      "oldPass" : oldPassword,
      "newPass" : newPassword
    };
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token");
    final response = await http.post(api_server + "/user/change-password", headers: {"Authorization": "Bearer $token"}, body: data);
    return response;
  }

  // ---- COURSES ----

  Future<List<CourseModelOnline>> fetchTopNewCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-new", body: {"limit":limit.toString(),"page":page.toString()});
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(response.body)["payload"] as List).map((data) => CourseModelOnline.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<CourseModelOnline>> fetchTopRateCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-rate", body: {"limit":limit.toString(),"page":page.toString()});
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(response.body)["payload"] as List).map((data) => CourseModelOnline.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<CourseModelOnline>> fetchTopSellCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-sell", body: {"limit":limit.toString(),"page":page.toString()});
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(
          response.body)["payload"] as List).map((data) =>
          CourseModelOnline.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<UserFavoriteCoursesModel>> fetchUserFavoriteCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    var response = await http.get(api_server +"/user/get-favorite-courses", headers: {"Authorization": "Bearer $token"});

    List<UserFavoriteCoursesModel> favoriteCourses = (jsonDecode(response.body)['payload'] as List).map((data) => UserFavoriteCoursesModel.fromJson(data)).toList();
    return favoriteCourses;
  }


  Future<List<UserProcessCoursesModel>> fetchUserProcessCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    var response = await http.get(api_server +"/user/get-process-courses", headers: {"Authorization": "Bearer $token"});
    List<UserProcessCoursesModel> courses = (json.decode(response.body)['payload'] as List).map((data) => UserProcessCoursesModel.fromJson(data)).toList();
    return courses;
  }

  Future<CourseModelOnline> fetchCourseWithID(String courseID) async {
    final response = await http.get(api_server + "/course/get-course-info?id=${courseID}");
    if (response.statusCode == 200){
      CourseModelOnline course = CourseModelOnline.fromJson(json.decode(response.body)['payload']);
      return course;
    }
    return null;
  }

  Future<CourseWithLessonModel> fetchCourseWithLession(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    final response = await http.get(api_server + "/course/detail-with-lesson/${courseId}/", headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      CourseWithLessonModel course = CourseWithLessonModel.fromJson(json.decode(response.body)['payload']);
      return course;
    }
    return null;
  }

  Future<List<SearchCourseModel>> fetchCoursesFromCategoryID(String cateID) async {
    Map<String, dynamic> data = {
      "keyword": "",
      "opt": {
        "sort": {
          "attribute": "updatedAt",
          "rule": "DESC"
        },
        "category": [cateID],
        "time": null,
        "price": null
      },
      "limit": 15,
      "offset": 1
    };
    var response = await http.post(api_server + "/course/search", headers: {"content-type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      List<SearchCourseModel> courses = (json.decode(response.body)["payload"]["rows"] as List).map((data) => SearchCourseModel.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<SearchCourseModel>> fetchSearchCoursesWithString(String searchString) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    Map<String, dynamic> data = {
      "token": token,
      "keyword": searchString,
      "limit": 10,
      "offset": 1,
      "opt": {
        "sort": {
          "attribute": "updatedAt",
          "rule": "DESC"
        },
        "category": [],
        "time": [],
        "price": []
      }
    };
    var response = await http.post(api_server + "/course/searchV2", headers: {"content-type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      List<SearchCourseModel> courses = (json.decode(response.body)["payload"]["courses"]["data"] as List).map((data) => SearchCourseModel.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<ExerciseModel>> fetchExercisesWithLessonID(String lessonID) async {
    Map<String, String> data = {
      "lessonId": lessonID
    };
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    final response = await http.post(api_server + "/exercise/student/list-exercise-lesson", headers: {"Authorization": "Bearer $token", "content-type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      List<ExerciseModel> exercises = (json.decode(response.body)["payload"]["exercises"] as List).map((data) => ExerciseModel.fromJson(data)).toList();
      return exercises;
    }
    return null;
  }

  Future<LessonVideoModel> fetchLessonVideoWithCourseIDAndLessonID(String courseID, String lessonID) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    final response = await http.get(api_server + "/lesson/video/" + courseID + "/" + lessonID, headers: {"Authorization": "Bearer $token", "content-type": "application/json"});
    if (response.statusCode == 200) {
      LessonVideoModel lessonVideo = LessonVideoModel.fromJson(json.decode(response.body)['payload']);
      return lessonVideo;
    }
    return null;
  }

  Future<List<SearchCourseModel>> fetchHistorySearchCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get("token");
    final response = await http.get(api_server + "/course/search-history", headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List<SearchCourseModel> courses = (json.decode(response.body)["payload"]["data"] as List).map((data) => SearchCourseModel.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  // ---- LIKE/JOIN COURSES ----
  Future likeCourseWithID(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    var response = await http.post(api_server + "/user/like-course", body: {"courseId": courseId}, headers: {"Authorization": "Bearer $token"});
    return response;
  }

  Future joinCourseWithID(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    var response = await http.post(api_server + "/payment/get-free-courses", body: {"courseId": courseId}, headers: {"Authorization": "Bearer $token"});
    return response;
  }

  // ---- CATEGORIES ----

  Future<List<CategoryModel>> fetchAllCategories() async {
    final response = await http.get(api_server + "/category/all");
    if (response.statusCode == 200) {
      List<CategoryModel> courses = (json.decode(response.body)["payload"] as List).map((data) => CategoryModel.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<CategoryModel> fetchCategoryWithID(String cateID) async {
    var response = await http.get(api_server + "/category/${cateID}");
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["payload"];
      CategoryModel category = new CategoryModel.fromJson(responseJson);
      return category;
    }
    else {
      return null;
    }
  }

  // ---- INSTRUCTORS ----
  Future<List<InstructorModel>> fetchInstructors()  async {
    var response = await http.get(api_server + "/instructor");
    List<InstructorModel> instructors = (json.decode(response.body)["payload"] as List).map((data) => InstructorModel.fromJson(data)).toList();
    return instructors;
  }

}