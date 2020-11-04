import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final WelcomeLabel = Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Welcome to iCourse!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            color: Color.fromRGBO(217, 217, 217, 1),
            fontWeight: FontWeight.bold,
            inherit: false,
          ),
        )
    );

    final LoginButton = Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 0.0),
        child: RaisedButton(
          padding: EdgeInsets.all(15),
          color: Color.fromRGBO(40, 75, 99, 1),
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: () {
          },
        )
    );

    final SignUpButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: RaisedButton(
          color: Color.fromRGBO(60, 110, 113, 1),
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "CREATE AN ACCOUNT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: (){
          },
        )
    );

    return Center(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('assets/HomePage/HomePageBG.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Color.fromRGBO(255, 255, 255, 0.75), BlendMode.modulate),
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                WelcomeLabel,
                LoginButton,
                SignUpButton,
              ]
          )
      ),
    );
  }
}