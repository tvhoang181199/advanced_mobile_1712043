import 'package:flutter/material.dart';
import 'package:DARKEN/Screens/Home/HomePage.dart';
import 'package:DARKEN/BottomTabbar.dart';

import 'package:DARKEN/Styling/AppColors.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static String tag = '/login-page';
  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailTextController = new TextEditingController();
    TextEditingController _passwordTextController = new TextEditingController();

    final node = FocusScope.of(context);

    Widget okButton = FlatButton(
      child: Text(
          "OK",
          style: TextStyle(
            color: AppColors.themeColor,
          ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
          "FAILED!",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
      ),
      content: Text("The username or password you entered is incorrect"),
      actions: [
        okButton,
      ],
    );

    void checkLogin() {
      if (_emailTextController.text == "username" && _passwordTextController.text == "password")
        Navigator.of(context).pushNamed(BottomTabbar.tag);
      else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
        });
      }
    }

    final emailTextField = TextField(
      controller: _emailTextController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: AppColors.buttonColor,
        ),
        prefixIcon: Icon(
          Icons.person,
          color: AppColors.themeColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 0.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1,
          ),
        ),
      ),
      cursorColor: AppColors.themeColor,
      style: TextStyle(
        color: AppColors.themeColor,
      ),
    );

    final passwordTextField = TextField(
      controller: _passwordTextController,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: AppColors.themeColor,
        ),
        prefixIcon: Icon(
          Icons.lock_outline_rounded,
          color: AppColors.themeColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1,
          ),
        ),
      ),
      cursorColor: AppColors.themeColor,
      style: TextStyle(
        color: AppColors.themeColor,
      ),
    );

    final loginButton = RaisedButton(
      padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
      color: AppColors.themeColor,
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
      onPressed: checkLogin,
    );

    final forgetPasswordButton = OutlineButton(
      padding: EdgeInsets.all(0),
      borderSide: BorderSide.none,
      child: Text(
        "Forget your password?",
        style: TextStyle(
          color: AppColors.themeColor,
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),

      onPressed: (){

      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('LOGIN'),
          backgroundColor: AppColors.themeColor,
        ),
        body: GestureDetector(
            onTap:() {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Center(
                child: Container (
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 100.0, top: 50.0, right: 100.0, bottom: 50.0),
                              child: AspectRatio(
                                aspectRatio: 1/1,
                                child: Image.asset(
                                  "assets/Icons/app_icon.png",
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            emailTextField,
                            SizedBox(height: 10.0),
                            passwordTextField,
                            SizedBox(height: 20.0),
                            loginButton,
                            forgetPasswordButton,
                          ]
                      ),
                    )
                )
            )
        )
    );
  }
}