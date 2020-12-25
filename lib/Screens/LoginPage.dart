import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:DARKEN/BottomTabbar.dart';
import 'package:DARKEN/Styling/AppColors.dart';
import 'package:DARKEN/APIs/APIServer.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String tag = '/login-page';
  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    void _checkLogin() async {
      var email = _emailController.text;
      var password = _passwordController.text;

      setState(() {
        _isLoading = true;
      });

      http.Response response = await APIServer().login(email, password);

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        node.unfocus();
        Navigator.of(context).pushNamed(BottomTabbar.tag);
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                  "LOGIN FAILED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.errorColor,
                      fontSize: 18.0
                  )
              ),
              content: Text(
                  "Username or password is invalid!"
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: Text("Try again", style: TextStyle(
                      color: AppColors.errorColor,
                      fontSize: 16.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    void _resetPassword() async {
      if (_emailController.text == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                  "FAILED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontSize: 18.0
                  )
              ),
              content: Text(
                  "Please enter your email in first textfield!"
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: Text("OK", style: TextStyle(
                      color: AppColors.themeColor,
                      fontSize: 16.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      else {
        var email = _emailController.text;

        setState(() {
          _isLoading = true;
        });

        http.Response response = await APIServer().forgetPassword(email);

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                      "RESET PASSWORD",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: AppColors.themeColor, fontSize: 18.0
                      )
                  ),
                  content: Text(
                    "Please check your email!",
                    style: TextStyle(
                        color: AppColors.darkGreyColor
                    ),
                  ),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    FlatButton(
                      child: Text("OK", style: TextStyle(
                          color: AppColors.themeColor, fontSize: 16.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }
        else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Failed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.errorColor, fontSize: 18.0)),
                  content: new Text("Email does not exist"),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Try Again", style: TextStyle(
                          color: AppColors.errorColor, fontSize: 16.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }
      }
    }

    final emailTextField = TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
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
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      onSubmitted: (v){
        _checkLogin();
      },
      keyboardType: TextInputType.text,
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
      onPressed: _checkLogin,
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
      onPressed: _resetPassword,
    );

    Widget loadingIndicator = _isLoading ? new Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
        Align(
          child: Container(
            color: Colors.grey[700],
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new CircularProgressIndicator()
                )
            ),
          ),
          alignment: FractionalOffset.center,
        )
      ],
    ) : new Container();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: GestureDetector(
            onTap:() {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children: <Widget>[
                Center(
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
                                      'assets/Icons/app-icon.png',
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
                ),
                Align(
                    child: loadingIndicator,
                    alignment: FractionalOffset.center
                )
              ],
            )
        )
    );
  }
}