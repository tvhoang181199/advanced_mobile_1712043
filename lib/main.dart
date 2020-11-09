import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:DARKEN/Screens/IntroPage.dart';
import 'package:DARKEN/Screens/LoginPage.dart';
import 'package:DARKEN/Screens/SignUpPage.dart';
import 'package:DARKEN/BottomTabbar.dart';

import 'package:DARKEN/Styling/AppColors.dart';

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
    };

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      title: 'DARKEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IntroPage.tag,
      routes: routes,
    );
  }
}