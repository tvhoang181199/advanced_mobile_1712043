import 'dart:ui';
import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/BottomTabbar.dart';
import 'package:DARKEN/Models/UserMeModel.dart';
import 'package:DARKEN/Screens/SignUpPage.dart';
import 'package:flutter/material.dart';

import 'package:DARKEN/Styling/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class IntroPage extends StatefulWidget {
  static String tag = '/intro-page';
  @override
  _IntroPage createState() => new _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  bool _isLoading = false;

  _checkToken() async {
    setState(() {
      _isLoading = true;
    });
    UserMeModel currentUser = await APIServer().fetchUserInfo();
    if (currentUser != null) {
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new BottomTabbar(),
          )
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override initState(){
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {

    final appNameLabel = Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 100.0),
        child: Text(
          "DARKEN",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            color: AppColors.darkGreyColor,
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
            "CREATE A NEW ACCOUNT",
            style: TextStyle(
              color: Color.fromRGBO(40, 75, 99, 1),
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: (){
            Navigator.of(context).pushNamed(SignUpPage.tag);
          },
        )
    );

    Widget loadingIndicator = _isLoading ? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Center(
              child: new CircularProgressIndicator()
          )
      ),
    ) : new Container();

    return Container(
      color: Colors.white,
      child: _isLoading ? loadingIndicator : Stack(
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
                      "assets/Icons/app-icon.png",
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