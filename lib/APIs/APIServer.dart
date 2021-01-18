import "dart:convert";
import "package:DARKEN/Models/CategoryModel.dart";
import "package:DARKEN/Models/CourseModelOnline.dart";
import "package:DARKEN/Models/InstructorModel.dart";
import 'package:DARKEN/Models/SearchCourseModel.dart';
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
      print("token : ${jsData["token"]}");
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
    final response = await http.get(api_server + "/user/me"
        ,headers: {"Authorization": "Bearer $token"}
    );
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      print("fetchUserInfo : " + response.body);
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
    final response = await http.put(api_server + "/user/update-profile",headers: {"Authorization": "Bearer $token"},body:data );
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
    final response = await http.post(api_server + "/user/change-password", headers: {"Authorization": "Bearer $token"},body: data);
    return response;
  }

  // ---- COURSES ----

  Future<List<CourseModelOnline>> fetchTopNewCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-new", body: {"limit":limit.toString(),"page":page.toString()});
    print("fetchTopNewCourses : " + response.body);
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(response.body)["payload"] as List).map((data) => CourseModelOnline.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<CourseModelOnline>> fetchTopRateCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-rate", body: {"limit":limit.toString(),"page":page.toString()});
    print("fetchTopRateCourses : " + response.body);
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(response.body)["payload"] as List).map((data) => CourseModelOnline.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<CourseModelOnline>> fetchTopSellCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-sell", body: {"limit":limit.toString(),"page":page.toString()});
    print("fetchTopSellCourses : " + response.body);
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(
          response.body)["payload"] as List).map((data) =>
          CourseModelOnline.fromJson(data)).toList();
      return courses;
    }
    return null;
  }

  Future<List<CourseModelOnline>> fetchFavoriteCourse() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    var response = await http.get(api_server +"/user/get-favorite-courses", headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List<CourseModelOnline> favoriteCourses = (jsonDecode(
          response.body)['payload'] as List).map((data) =>
          CourseModelOnline.fromJson(data)).toList();
      return favoriteCourses;
    }
    return null;
  }

  Future<List<CourseModelOnline>> fetchMyCourse() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    var response = await http.get(api_server +"/user/get-process-courses",headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List<CourseModelOnline> courses = (json.decode(
          response.body)['payload'] as List).map((data) =>
          CourseModelOnline.fromJson(data)).toList();
      return courses;
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
    print("RESPONSE----" + response.body);
    if (response.statusCode == 200) {
      List<SearchCourseModel> courses = (json.decode(response.body)["payload"]["rows"] as List).map((data) => SearchCourseModel.fromJson(data)).toList();

      return courses;
    }
    return null;
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

  Future<List<InstructorModel>> fetchInstructors()  async {
    var response = await http.get(api_server + "/instructor");
    print("fetchInstructor : " + response.body);
    List<InstructorModel> instructors = (json.decode(response.body)["payload"] as List).map((data) => InstructorModel.fromJson(data)).toList();
    return instructors;
  }

}