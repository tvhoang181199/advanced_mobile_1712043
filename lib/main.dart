import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:DARKEN/Screens/IntroPage.dart';
import 'package:DARKEN/Screens/LoginPage.dart';
import 'package:DARKEN/Screens/SignUpPage.dart';
import 'package:DARKEN/BottomTabbar.dart';
import 'package:DARKEN/Screens/Account/ProfilePage.dart';
import 'package:DARKEN/Screens/Account/ProfileDetailPage.dart';
import 'package:DARKEN/Screens/Browse/BrowsePage.dart';
import 'package:DARKEN/Screens/Download/DownloadPage.dart';
import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';
import 'package:DARKEN/Screens/Home/CoursesFilteredPage.dart';
import 'package:DARKEN/Screens/Home/HomePage.dart';
import 'package:DARKEN/Screens/Search/SearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      IntroPage.tag: (context) => IntroPage(),
      LoginPage.tag: (context) => LoginPage(),
      SignUpPage.tag: (context) => SignUpPage(),
      BottomTabbar.tag: (context) => BottomTabbar(),
      ProfilePage.tag: (context) => ProfilePage(),
      ProfileDetailPage.tag: (context) => ProfileDetailPage(),
      BrowsePage.tag: (context) => BrowsePage(),
      DownloadPage.tag: (context) => DownloadPage(),
      CourseDetailPage.tag: (context) => CourseDetailPage(),
      CoursesFilteredPage.tag: (context) => CoursesFilteredPage(),
      HomePage.tag: (context) => HomePage(),
      SearchPage.tag: (context) => SearchPage(),
    };

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      title: 'DARKEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IntroPage.tag,
      routes: routes,
    );
  }
}