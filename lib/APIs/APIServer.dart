import 'dart:convert';
import 'package:DARKEN/BottomTabbar.dart';
import 'package:DARKEN/Models/CourseModel.dart';
import 'package:DARKEN/Models/InstructorModel.dart';
import 'package:DARKEN/Models/UserModel.dart';
import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DARKEN/Models/UserMeModel.dart';
import 'Constant-server.dart';

class APIServer{
  Future login(String email, String password) async{
    Map data = {
      'email': email,
      'password': password
    };
    var response = await http.post(api_server + "/user/login",body: data);
    var jsData = jsonDecode(response.body);

    if (response.statusCode == 200){
      final prefs = await SharedPreferences.getInstance();
      print('token : ${jsData["token"]}');
      updateToken(jsData["token"]);
    }
    return response;
  }

  updateToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  Future register(String username, String email, String phone, String password) async{
    Map data = {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password
    };
    var response = await http.post(api_server + "/user/register",body: data);
    return response;
  }

  Future forgetPassword(String email) async {
    Map data = {
      'email': email
    };
    var response = await http.post(api_server + "/user/forget-pass/send-email",body: data);
    return response;
  }

  Future<UserMeModel> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
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

 Future fetchTopNewCourses(int limit, int page) async {
   var response = await http.post(api_server + "/course/top-new", body: {'limit':limit,'page':page});
   print("fetchTopNewCourses : " + response.body);
   List<CourseModel> courses = (json.decode(response.body)['payload'] as List).map((data) => CourseModel.fromJson(data)).toList();
   return courses;
 }

 Future fetchTopRateCourses(int limit, int page) async {
   var response = await http.post(api_server + "/course/top-rate", body: {'limit':limit,'page':page});
   print("fetchTopRateCourses : " + response.body);
   List<CourseModel> courses = (json.decode(response.body)['payload'] as List).map((data) => CourseModel.fromJson(data)).toList();
   return courses;
 }

  Future fetchTopSellCourses(int limit, int page) async {
    var response = await http.post(api_server + "/course/top-sell", body: {'limit':limit,'page':page});
    print("fetchTopRateCourses : " + response.body);
    List<CourseModel> courses = (json.decode(response.body)['payload'] as List).map((data) => CourseModel.fromJson(data)).toList();
    return courses;
  }
  
  Future<List<InstructorModel>> fetchInstructors()  async {
    var response = await http.get(api_server + "/instructor");
    print("fetchInstructor : " + response.body);
    List<InstructorModel> instructors = (json.decode(response.body)['payload'] as List).map((data) => InstructorModel.fromJson(data)).toList();
    return instructors;
  }

}