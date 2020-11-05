import 'package:flutter/material.dart';
import 'Screens/IntroPage.dart';
import 'Screens/LoginPage.dart';
import 'Screens/SignUpPage.dart';

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
    };

    return MaterialApp(
      title: 'DARKEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IntroPage.tag,
      routes: routes,
    );
  }
}