import 'dart:convert';
import 'dart:js';
import 'package:DARKEN/BottomTabbar.dart';
import 'package:DARKEN/Models/InstructorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      print('data : ${jsData["token"]}');
      saveToken(jsData["token"]);
    }
    return response;
  }

  saveToken(String token) async {
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
    print(token); //TODO
    final response = await http.get(api_server + "/user/me"
        ,headers: {"Authorization": "Bearer $token"}
    );
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      print(response.body + " ---- ");
      UserMeModel  userMe = new UserMeModel.fromJson(responseJson);
      return userMe;
    }
    else {
      UserMeModel userMe = new UserMeModel();
      return userMe;
    }
  }

 Future getNewCourse(int limit, int page) async {
   var response = await http.post(api_server + "/course/top_new",body: {'limit':limit,'page':page});
   return response;
 }
  
  Future<InstructorModel> getInstructor()  async {
    var response = await http.get(api_server + "/instructor");
    return InstructorModel.fromJson(jsonDecode(response.body));
  }

}