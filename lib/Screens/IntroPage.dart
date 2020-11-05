import 'dart:ui';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class IntroPage extends StatefulWidget {
  static String tag = '/intro-page';
  @override
  _IntroPage createState() => new _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {

    final appNameLabel = Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 100.0),
        child: Text(
          "DARKEN",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            color: Color.fromRGBO(35, 35, 35, 1),
            fontWeight: FontWeight.bold,
            inherit: false,
          ),
        )
    );

    final loginButton = Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
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
            Navigator.of(context).pushNamed(LoginPage.tag);
          },
        )
    );

    final signUpButton = Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: OutlineButton(
          padding: EdgeInsets.all(15),
          borderSide: BorderSide(color: Color.fromRGBO(40, 75, 99, 1), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "CREATE AN ACCOUNT",
            style: TextStyle(
              color: Color.fromRGBO(40, 75, 99, 1),
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: (){
          },
        )
    );

    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  loginButton,
                  signUpButton,
                ]
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(75.0, 0.0, 75.0, 0.0),
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.asset(
                      "assets/Icons/app_icon.png",
                    ),
                  ),
                ),
                appNameLabel,
              ],
            ),
          )
        ],
      ),
    );
  }
}